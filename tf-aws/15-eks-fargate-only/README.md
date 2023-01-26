# How to Create Fargate Using Terraform
No node group, only fargate


aws eks --region us-east-1 update-kubeconfig --name demo

# Verify Kubernetes Worker Nodes using kubectl
kubectl get nodes
kubectl get nodes -o wide

# List Fargate Profiles
aws eks list-fargate-profiles --cluster=demo

# Verify Pods 
kubectl -n kube-system get pods
Observation: Should see coredns pods in pending state

# Run the following command to remove the eks.amazonaws.com/compute-type : ec2 annotation from the CoreDNS pods.
kubectl patch deployment coredns \
    -n kube-system \
    --type json \
    -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'

# Delete & Recreate CoreDNS Pods so that they can get scheduled on Fargate 
kubectl rollout restart -n kube-system deployment coredns

# Verify Pods 
kubectl -n kube-system get pods
Observation: 
1. Wait for a minute or two
2. Should see coredns pods in Running state

# Verify Worker Nodes
kubectl get nodes
Observation: Should see two Fargate nodes related to CoreDNS running

# Verify Sample Apps Deployment & Pods in fp-ns-app1 namespace
kubectl -n fp-ns-app1 get pods
kubectl -n fp-ns-app1 get deploy

# Access Application
Load balancer was not created 


