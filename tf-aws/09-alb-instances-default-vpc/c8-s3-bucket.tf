
resource "aws_s3_bucket" "alb_access_logs" {
  bucket        = var.s3_bucket_name
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.alb_access_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/*
effect = "Allow" is default
*/
data "aws_iam_policy_document" "s3_bucket_policy" {

  statement {
    actions = [
      "s3:PutObject"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.elb_account_id}:root"]
    }

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
    ]
  }

}

resource "aws_s3_bucket_policy" "allow_alb_to_log" {
  bucket = aws_s3_bucket.alb_access_logs.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}