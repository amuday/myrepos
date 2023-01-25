provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~>1.0"
    }

  }
}

data "aws_eks_cluster" "demo" {
  name = data.terraform_remote_state.eks.outputs.cluster
}

data "aws_eks_cluster_auth" "demo" {
  name = data.terraform_remote_state.eks.outputs.cluster
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.demo.token
}

