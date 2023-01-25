# commented as Service Account is created as part of helm chart

/*
data "kubectl_path_documents" "lb_sa" {
  pattern = "${path.module}/k8s/load-balancer-controller-service-account.yaml"

  vars = {
    "account_id"      =  data.aws_caller_identity.current.account_id
    "lb_Iam_role_name" = aws_iam_role.lbc.name
  }

}


resource "kubectl_manifest" "lb_sa" {
  for_each   = toset(data.kubectl_path_documents.lb_sa.documents)
  yaml_body  = each.value
  depends_on = [aws_eks_cluster.demo]
}

*/