
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
    ]
  }
}


resource "aws_iam_role" "s3_bucket_role" {
  name               = "s3_bucket_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "s3_bucket_role_instance_profile" {
  name = "s3_bucket_role_instance_profile"
  role = aws_iam_role.s3_bucket_role.name
}

resource "aws_iam_role_policy" "s3_bucket_role_policy" {
  name   = "s3_bucket_role_policy"
  role   = aws_iam_role.s3_bucket_role.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}