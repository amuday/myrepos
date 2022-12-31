
# VPC steps
    Create VPC
    Create Public and Private Subnets
    Create Internet Gateway and Associate to VPC
    Create NAT Gateway in Public Subnet
    Create Public Route Table, Add Public Route via Internet Gateway and Associate Public Subnet
    Create Private Route Table, Add Private Route via NAT Gateway and Associate Private Subnet


# inside exmaple intance
    route -n 


# Code creation steps
    1. Create VPC (c2-1)
    2. Create SG and an instance in public subnet (c1-5, c3-1)
    3. Create EBS volume and attach it
       **** volume need to be mounted before using it. Use manual steps or userdata script.
       **** ebs creation  is one time, create before ec2 instnace creation and use user data to mount it.