data "kubectl_path_documents" "nlb" {
  pattern = "${path.module}/k8s/public-lb.yaml"
}

resource "kubectl_manifest" "nlb" {
  for_each   = toset(data.kubectl_path_documents.alb.documents)
  yaml_body  = each.value
  depends_on = [aws_eks_cluster.demo]
}