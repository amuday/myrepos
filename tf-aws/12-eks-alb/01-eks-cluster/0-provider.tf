provider "aws" {
  region = var.region
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

    helm = {
      source  = "hashicorp/helm"
      version = "~>2.8"
    }

  }

   backend "s3" {
    bucket = "terraform-aws-eks-ukam"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-ekscluster"
  }
}



provider "kubectl" {
  host                   = data.aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.demo.token
  load_config_file       = false
}


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.demo.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.demo.token
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.demo.token
}
