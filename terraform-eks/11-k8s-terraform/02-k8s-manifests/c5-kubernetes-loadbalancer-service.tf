resource "kubernetes_service_v1" "lb_service" {
  metadata {
    name = "myapp1-lb-service"
  }
  spec {
    selector = {
      #app = "myapp1"
      # include 0 for blocks and for arguments not needed. In deployment config file spec and selector are blocks and match label is an argument.
      # as per terraform you can have multiple spec blocks but according to k8s its not allowed.
      app = kubernetes_deployment_v1.myapp1.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

