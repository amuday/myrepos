https://github.com/wardviaene/terraform-course/tree/master/demo-14

# IAM Roles
    Roles can give users / services (temporary) access that they normally wouldn’t have
    • The roles can be attached to EC2 instances
        • From that instance, a user or service can obtain access credentials
        • Using those access credentials the user or service can assume the role, which gives them permission to do something.

    An example:
        • You create a role mybucket-access and assign the role to an EC2 instance at boot time
        • To the role you give the permissions to read and write items in "mybucket"
        • When you log in, you can now assume this mybucket-access role, without using your own credentials - you will be given temporary access credentials which just look like normal user credentials 
        • You can now read and write items in "mybucket"

• IAM Roles only work on EC2 instances, and not for instance outside AWS

# Objective 
    Access s3 from EC2 without credentials

# aws cli install
    https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

# validation
    SSH into EC2 instance
    Install aws cli

    echo "test" > test.txt
    aws s3 cp test.txt s3://ukam-my-tf-test-bucket/test.txt # file is copied to s3 bucket

    # to check s3 access key 
    curl http://169.254.169.254/latest/meta-data
    curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
    curl http://169.254.169.254/latest/meta-data/iam/security-credentials/s3_bucket_role
