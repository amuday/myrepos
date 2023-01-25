# https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
# https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
data "http" "lbc_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.4/docs/install/iam_policy.json"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}


resource "aws_iam_policy" "lbc" {
  name   = "lbc_iam_policy"
  policy = data.http.lbc_policy.response_body
}

locals {
  lb_sa_name = "aws-load-balancer-controller"
}

data "aws_iam_policy_document" "lbc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${local.aws_iam_oidc_connect_provider_extract_from_arn}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub"
      values   = ["system:serviceaccount:kube-system:${local.lb_sa_name}"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }

}

# resource policy
resource "aws_iam_role" "lbc" {
  name               = "lbc_role"
  assume_role_policy = data.aws_iam_policy_document.lbc.json
}

resource "aws_iam_role_policy_attachment" "lbc" {
  role       = aws_iam_role.lbc.name
  policy_arn = aws_iam_policy.lbc.arn
}



