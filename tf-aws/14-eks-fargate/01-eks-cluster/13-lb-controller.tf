locals {
  lb_namespace = "lb-namespace"
}

/*
resource "kubernetes_namespace" "lb" {
  metadata {
    name = local.lb_namespace
  }
}

*/

/*
resource "kubernetes_service_account_v1" "lb_service_account" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = local.lb_namespace

    labels = {
      "app.kubernetes.io/component": "controller"
      "app.kubernetes.io/name": "aws-load-balancer-controller"
    }

    annotations = {
    "eks.amazonaws.com/role-arn" : "arn:aws:iam::${account_id}:role/${lb_Iam_role_name}"
    "eks.amazonaws.com/sts-regional-endpoints" : true
    }

  }
}
*/

resource "helm_release" "loadbalancer_controller" {
  depends_on = [aws_iam_role.lbc]
  name       = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  namespace = "kube-system"
  #namespace = local.lb_namespace

  # Value changes based on your Region (Below is for us-east-1)
  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller"
    # Changes based on Region - This is for us-east-1 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = local.lb_sa_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.lbc.arn
  }

  set {
    name  = "vpcId"
    value = aws_vpc.main.id
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "clusterName"
    value = aws_eks_cluster.demo.name
  }

}


# Helm Release Outputs
output "lbc_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.loadbalancer_controller.metadata
}