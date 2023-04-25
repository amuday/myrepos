
# ECR access
Option 1: 
    Here enabling public IP for container
    03-main.tf -> aws_ecs_service -> assign_public_ip=true

Option 2:
    VPC end point
    
# autoscaling is disabled
    Its working but commented the code


https://www.chakray.com/creating-fargate-ecs-task-aws-using-terraform/

# scheduled task
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/scheduled_tasks.html
