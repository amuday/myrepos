To set up autoscaling in AWS you need to setup at least 2 resources:
    • An AWS launch configuration
        • Specifies the properties of the instance to be launched (AMI ID, security group, etc)
    • An autoscaling group
        • Specifies the scaling properties (min instances, max instances, health checks)

• Once the autoscaling group is setup, you can create autoscaling policies
    • A policy is triggered based on a threshold (CloudWatch Alarm)
    • An adjustment will be executed
        • e.g. if the average CPU utilization is more than 20%, then scale up  by +1 instances
        • e.g. if the average CPU utilization is less than 5%, then scale down by -1 instances

# validation
    SSH into EC2 instance
    sudo amazon-linux-extras install epel -y
    sudo yum install stress -y
    stress --cpu 2 --timeout 300

Autoscaling group
Autoscaling group policies 
    example-cpu-policy
    example-cpu-policy-scaledown

cloud watch metrics
After 5 min, stress goes down and second EC2 instance will be deleted

    