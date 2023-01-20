# trust policy - defines which identities can assume the role
# Trust policy is an example of Resource based policy. Below is resource based policy - because it has principal
resource "aws_iam_role" "s3_bucket_role" {
  name = "s3_bucket_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "s3_bucket_role_instance_profile" {
  name = "s3_bucket_role_instance_profile"
  role = aws_iam_role.s3_bucket_role.name
}

# permission policy - define what actions and resources the role can use
# permission policy is an example of identity based policy
# defines which AWS resources the IAM role can access.
resource "aws_iam_role_policy" "s3_bucket_role_policy" {
  name = "s3_bucket_role_policy"
  role = aws_iam_role.s3_bucket_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::ukam-my-tf-test-bucket",
          "arn:aws:s3:::ukam-my-tf-test-bucket/*",
        ]
      },
    ]
  })

}