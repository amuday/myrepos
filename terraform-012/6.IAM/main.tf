provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "myiamuser" {
  name = "kumar"
}

resource "aws_iam_policy" "custompolicy" {
  name   = "GlacierEFSEC2"
  policy = file("policy.txt")
}

resource "aws_iam_policy_attachment" "policyBind" {
  name       = "attachment"
  users      = [aws_iam_user.myiamuser.name]
  policy_arn = aws_iam_policy.custompolicy.arn
}