resource "aws_ecs_cluster" "main" {
  name = "demo-ecs-cluster"
}


resource "aws_cloudwatch_log_group" "main" {
  name = "demo-ecs-cluster-logs"
}

resource "aws_ecs_task_definition" "main" {
  family                   = "demo-family"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  # below can be different
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<TASK_DEFINITION
[
  {
    "name": "pyhton-demo",
    "image": "760030951132.dkr.ecr.us-east-1.amazonaws.com/my-aws-ecr-repo:main-1.0",
    "essential": true,
     "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.main.id}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "demo-pyhton-poc"
        }
      }
  }
]
TASK_DEFINITION

}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT RULE
#------------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = "POC"
  schedule_expression = "rate(5 minutes)"
  role_arn            = aws_iam_role.ecs_task_execution_role.arn
  is_enabled          = true
  tags = {
    Name = "poc-cw-event-rule"
  }
}

#------------------------------------------------------------------------------
# CLOUDWATCH EVENT TARGET
#------------------------------------------------------------------------------
resource "aws_cloudwatch_event_target" "ecs_scheduled_task" {
  rule           = aws_cloudwatch_event_rule.event_rule.name
  event_bus_name = aws_cloudwatch_event_rule.event_rule.event_bus_name
  arn            = aws_ecs_cluster.main.arn
  role_arn       = aws_iam_role.scheduled_task_cw_event_role.arn

  ecs_target {
    launch_type         = "FARGATE"
    platform_version    = "LATEST"
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.main.arn

    network_configuration {
      subnets          = data.aws_subnets.default.ids
      assign_public_ip = true
    }
  }
}
