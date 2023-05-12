
# Pre requisite
Run job to create docker image and push into AWS 
    https://gitlab.com/aws6570716/aws-batch


# ECR access
Option 1: 
    Here enabling public IP for container
    03-main.tf -> aws_ecs_service -> assign_public_ip=true

Option 2:
    VPC end point
    
# autoscaling is disabled
    Its working but commented the code

# scope
Define ECS service and task definition

Service will keep the task running always


# validation 
    check cloudwatch log groups