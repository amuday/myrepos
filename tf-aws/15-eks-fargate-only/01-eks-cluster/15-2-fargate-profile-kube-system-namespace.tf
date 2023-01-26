# Resource: EKS Fargate Profile
resource "aws_eks_fargate_profile" "fargate_profile_kube_system" {
  cluster_name           = aws_eks_cluster.demo.id
  fargate_profile_name   = "fp-kube-system"
  pod_execution_role_arn = aws_iam_role.fargate_profile_role.arn
  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]
  selector {
    namespace = "kube-system"
    # Enable the below labels if we want only CoreDNS Pods to run on Fargate from kube-system namespace
    #labels = { 
    #  "k8s-app" = "kube-dns"
    #}
  }
}


# Outputs: Fargate Profile for kube-system Namespace
output "kube_system_fargate_profile_arn" {
  description = "Fargate Profile ARN"
  value       = aws_eks_fargate_profile.fargate_profile_kube_system.arn
}

output "kube_system_fargate_profile_id" {
  description = "Fargate Profile ID"
  value       = aws_eks_fargate_profile.fargate_profile_kube_system.id
}

output "kube_system_fargate_profile_status" {
  description = "Fargate Profile Status"
  value       = aws_eks_fargate_profile.fargate_profile_kube_system.status
}
