resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

/*
This policy provides Kubernetes the permissions it requires to manage resources on your behalf. 
Kubernetes requires Ec2:CreateTags permissions to place identifying information on EC2 resources including 
but not limited to Instances, Security Groups, and Elastic Network Interfaces.
*/

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "demo" {
  name     = var.cluster_name
  role_arn = aws_iam_role.demo.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
}


data "aws_eks_cluster" "demo" {
  name = aws_eks_cluster.demo.name
}

data "aws_eks_cluster_auth" "demo" {
  name = aws_eks_cluster.demo.name
}


output "cluster" {
  value = aws_eks_cluster.demo.name
}


output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = aws_eks_cluster.demo.certificate_authority[0].data
}

