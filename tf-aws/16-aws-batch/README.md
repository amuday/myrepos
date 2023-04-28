# aws-batch

Created ECR repository manually. You can automate it if needed.

# scope
    Deploy batch definitions
    Create event bridge schedule to run batch for every 5 min


# python image
    check for vulnerabilites section
https://hub.docker.com/_/python/tags?page=1&name=3.11.3-slim

# terraform code reference

https://registry.terraform.io/modules/terraform-aws-modules/batch/aws/latest
https://github.com/terraform-aws-modules/terraform-aws-batch/blob/v1.2.2/main.tf

https://github.com/terraform-aws-modules/terraform-aws-batch/blob/v1.2.2/examples/fargate/main.tf **

# Error conatiner pull
    Assign public IP ********* else error will come

    # Solution
     networkConfiguration = { 
        "assignPublicIp" = "ENABLED"
    }

    # Error
    ResourceInitializationError: unable to pull secrets or registry auth: execution resource retrieval failed: unable to retrieve ecr registry auth: service call has been retried 3 time(s): RequestError: send request failed caused by: Post "https://api.ecr.us-east-1.amazonaws.com/": dial tcp 52.46.128.2:443: i/o timeout. Please check your task network configuration.
# VPC Endpoints

VPC Endpoints allow you to have private containers, pulled from ECR repositories, with no external network ingress or egress.

# Execution steps

Run gitlab pipeline from gitlab
Run terraform code from local machine