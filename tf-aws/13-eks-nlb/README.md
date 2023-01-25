# How to Create ALB in EKS Using Terraform


aws eks --region us-east-1 update-kubeconfig --name demo
kubectl get ingress
http://<ALB-DNS-URL>
or
http://<INGRESS-ADDRESS-FIELD>

kubectl -n kube-system get deployment aws-load-balancer-controller

kubectl -n kube-system get svc aws-load-balancer-webhook-service
kubectl -n kube-system get sa aws-load-balancer-controller


# Check load balance controller, autoscaller
kubectl get po -n kube-system

kubectl logs -n kube-system aws-load-balancer-controller-585db6c64-ntpgv

http://ingress-cpr-23289885.us-east-1.elb.amazonaws.com/
http://ingress-cpr-23289885.us-east-1.elb.amazonaws.com/app1/
http://ingress-cpr-23289885.us-east-1.elb.amazonaws.com/app2/




