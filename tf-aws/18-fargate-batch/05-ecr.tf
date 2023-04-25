data "aws_ecr_repository" "main" {
  name = "my-aws-ecr-repo"
}


resource "aws_ecr_lifecycle_policy" "main" {
  repository = data.aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "keep last 2 images"
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 2
      }
    }]
  })
}