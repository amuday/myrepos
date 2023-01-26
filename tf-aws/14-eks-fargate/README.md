# How to Create ALB in EKS Using Terraform


aws eks --region us-east-1 update-kubeconfig --name demo
# Verify Kubernetes Worker Nodes using kubectl. Observation: New Fargate nodes will be created

kubectl get nodes
kubectl get nodes -o wide

# Verify Deployments
kubectl -n fp-ns-app1 get deploy

# Verify Pods
kubectl -n fp-ns-app1 get pods

# Verify Services
kubectl -n fp-ns-app1 get svc

# Verify Ingress Service
kubectl -n fp-ns-app1 get ingress

# List Fargate Profiles
aws eks list-fargate-profiles --cluster <CLUSTER_NAME>
aws eks list-fargate-profiles --cluster demo

# Review the aws-auth ConfigMap and verify fargate profile
kubectl -n kube-system get configmap aws-auth -o yaml

# Get the current user configured in AWS CLI (EKS Cluster Creator user)
aws sts get-caller-identity

http://fargate-profile-demo-1226261599.us-east-1.elb.amazonaws.com/
http://fargate-profile-demo-1226261599.us-east-1.elb.amazonaws.com/app1
http://fargate-profile-demo-1226261599.us-east-1.elb.amazonaws.com/app2


# CPU and memory default limit
kubectl -n fp-ns-app1 describe pod app1-nginx-deployment-7cfb98865b-z84d2

# Requests limit
kubectl -n fp-ns-app1 describe pod app3-nginx-deployment-84ff6477c6-ssflb


