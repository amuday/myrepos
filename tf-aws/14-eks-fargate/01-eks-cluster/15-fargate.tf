resource "kubernetes_namespace_v1" "fp_ns_app1" {
  metadata {
    name = "fp-ns-app1"
  }
}

# Resource: IAM Role for EKS Fargate Profile
resource "aws_iam_role" "fargate_profile_role" {
  name = "eks-fargate-profile-role-apps"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# Resource: IAM Policy Attachment to IAM Role
resource "aws_iam_role_policy_attachment" "eks_fargate_pod_execution_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_profile_role.name
}

# Resource: EKS Fargate Profile
resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = data.aws_eks_cluster.demo.name
  fargate_profile_name   = "fp-app1"
  pod_execution_role_arn = aws_iam_role.fargate_profile_role.arn
  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]
  selector {
    #namespace = "fp-ns-app1"
    namespace = kubernetes_namespace_v1.fp_ns_app1.metadata[0].name
  }
}

# Fargate Profile Outputs
output "fargate_profile_arn" {
  description = "Fargate Profile ARN"
  value       = aws_eks_fargate_profile.fargate_profile.arn
}

output "fargate_profile_id" {
  description = "Fargate Profile ID"
  value       = aws_eks_fargate_profile.fargate_profile.id
}

output "fargate_profile_status" {
  description = "Fargate Profile Status"
  value       = aws_eks_fargate_profile.fargate_profile.status
}