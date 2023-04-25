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

resource "aws_ecs_service" "main" {
  name                = "pyhton-demo-service"
  cluster             = aws_ecs_cluster.main.id
  task_definition     = aws_ecs_task_definition.main.arn
  desired_count       = 1
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    assign_public_ip = true #false
  }

}