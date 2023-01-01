ALB with autoscaling groups



# validataion 
    host <ALB url>
    Try with metadata url and check the private IP to see data coming from diff instances
    http://alb-test-1427032451.us-east-1.elb.amazonaws.com
    http://alb-test-1427032451.us-east-1.elb.amazonaws.com/app1
    http://alb-test-522531931.us-east-1.elb.amazonaws.com/app1/metadata.html

    As instances are behind load balancer and security group does not allow outside world to connect. So cant access it from browser directly. 