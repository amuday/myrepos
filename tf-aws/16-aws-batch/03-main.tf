data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id
}

################################################################################
# Compute Environment(s)
################################################################################
resource "aws_batch_compute_environment" "this" {
  compute_environment_name = "batch-compute-env"

  compute_resources {
    max_vcpus = 4
    #security_group_ids = [aws_security_group.this.id]
    security_group_ids = [aws_security_group.vpc_endpoint.id]
    subnets            = data.aws_subnets.default.ids
    type               = "FARGATE"
  }

  service_role = aws_iam_role.aws_batch_service_role.arn
  type         = "MANAGED"
  depends_on   = [aws_iam_role_policy_attachment.aws_batch_service_role]
}

################################################################################
# Job Queue
################################################################################

resource "aws_batch_job_queue" "this" {
  name                 = "test-batch-job-queue"
  state                = "ENABLED"
  priority             = 1
  compute_environments = [aws_batch_compute_environment.this.arn]
}

################################################################################
# Job Definitions
################################################################################

resource "aws_batch_job_definition" "this" {
  name = "test_batch_job_definition"
  type = "container"

  platform_capabilities = [
    "FARGATE",
  ]

  container_properties = jsonencode({
    command = ["python", "./myfunction.py"]
    image   = "760030951132.dkr.ecr.us-east-1.amazonaws.com/my-aws-ecr-repo:main-1.0"

    fargatePlatformConfiguration = {
      platformVersion = "LATEST"
    }

    # if commented then enable vpc endpoints
    networkConfiguration = {
      "assignPublicIp" = "ENABLED"
    }


    resourceRequirements = [
      {
        type  = "VCPU"
        value = "0.25"
      },
      {
        type  = "MEMORY"
        value = "512"
      }
    ]

    executionRoleArn = aws_iam_role.ecs_task_execution_role.arn

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.this.id
        awslogs-region        = var.region
        awslogs-stream-prefix = "test_batch_job_definition"
      }
    }

  })
}


resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/batch/demo"
  retention_in_days = 1

  #tags = local.tags
}

resource "aws_scheduler_schedule" "example" {
  name = "my-schedule"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(5 minutes)"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:batch:submitJob"
    role_arn = aws_iam_role.ecs_task_execution_role.arn

    input = jsonencode({
      JobDefinition : "${aws_batch_job_definition.this.name}"
      JobName : "myjob"
      JobQueue : "${aws_batch_job_queue.this.name}"
    })
  }
}