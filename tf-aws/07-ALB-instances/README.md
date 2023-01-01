Application Load Balancer 
    Routes traffic based on application level information

Classic Load balancer (ELB)    
    Routes traffic based on network information

ELB is doing health check not autoscaling group

ALB with instances directly

# validataion 
    host <ALB url>
    Try with metadata url and check the private IP to see data coming from diff instances
    http://alb-test-522531931.us-east-1.elb.amazonaws.com/app1/metadata.html

    As instances are behind load balancer and security group does not allow outside world to connect. So cant access it from browser directly. 