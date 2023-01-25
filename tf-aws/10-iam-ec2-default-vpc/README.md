# Introduction

* IAM role can’t be directly attached to an EC2 instance. Therefore, first instance profile needs to be created with the role and then the instance profile is attached to an instance.
* When using the IAM console to create an IAM role for EC2, an instance profile with the same name is created.
* Using CLI, SDKs , Terraform and CloudFormation, needs roles and instance profiles to be created separately.
* After an instance profile is created with a role, It can be attached to an instance.
* An instance profile can only have one role at a time. However, one role can belong to multiple instance profiles.

# Covered in this demo
    Creating a test file inside EC2 and copying to s3
    
# Steps
    Created aws_iam_instance_profile and attached to EC2
    Inside EC2 
        installed AWS CLI
        created a test file 
        copied test file to S3

# Validation
    Verify the IAM role assignment for the EC2 instance in the console
    Veify data in S3 bucket.

    # to check s3 access key 
    curl http://169.254.169.254/latest/meta-data
    curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
    curl http://169.254.169.254/latest/meta-data/iam/security-credentials/s3_bucket_role