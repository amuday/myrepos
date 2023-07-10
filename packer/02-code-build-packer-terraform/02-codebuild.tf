resource "aws_cloudwatch_log_group" "packer" {
  name              = "/aws/codebuild/${var.prefix}-automation-packer"
  retention_in_days = 1
}

resource "aws_codebuild_project" "packer" {
  name = "${var.prefix}-automation-packer"
  // The resource id isn't important, it's there to force dependency on the resource.
  //description  = "Runs Packer to build AMI${substr(null_resource.delay.id, 0, 0)}"
  service_role = aws_iam_role.service.arn

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.packer.name
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "S3"
    location  = "${aws_s3_bucket_object.sources.bucket}/${aws_s3_bucket_object.sources.key}"
  }

  tags = var.tags

  vpc_config {
      security_group_ids = [aws_security_group.codebuild-egress.id]
      subnets            = [data.aws_subnets.this.ids[0], data.aws_subnets.this.ids[1]]
      vpc_id             = data.aws_vpc.this.id  
  }
}

resource "aws_s3_bucket" "source" {
  acl    = "private"
  bucket = local.bucket_name
  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "aws:kms"
  #     }
  #   }
  # }
  tags = merge(var.tags, { Name : local.bucket_name })
  # versioning {
  #   enabled = true
  # }
}

data "archive_file" "sources" {
  type        = "zip"
  output_path = "${path.module}/sources.zip"
  source_dir  = "${path.module}/packer"
}

resource "aws_s3_bucket_object" "sources" {
  #storage_class = "STANDARD_IA"
  acl           = "private"
  bucket        = aws_s3_bucket.source.bucket
  key           = "codebuild/sources.zip"
  source        = data.archive_file.sources.output_path
  etag          = data.archive_file.sources.output_md5
}
