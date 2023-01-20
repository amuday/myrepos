# How to Create EKS Cluster Using Terraform

 You can find tutorial [here](https://antonputra.com/terraform/how-to-create-eks-cluster-using-terraform/).

 https://antonputra.com/terraform/how-to-create-eks-cluster-using-terraform/

1. Create VPC
2. create cluster
3. create node group
4. create OIDC
5. autoscale
 

# Error
    Node type was t3.small and node group creation was taking time. Changed to t3.medium created without any issue.
 
 1. Run terraform apply without 10-iam-autoscaler.tf
 2. aws eks --region us-east-1 update-kubeconfig --name demo
 3. update aws-test.yaml with arn 
 4. kubectl.exe apply -f k8s/aws-test.yaml
    kubectl.exe exec aws-cli -- aws s3api list-buckets
    kubectl.exe apply -f k8s\deployment.yaml
    kubectl.exe apply -f k8s\public-lb.yaml
    kubectl get po
    kubectl get svc
    http://ab77a53f59c694f7d8d58176925f9c89-4e78d4c659df5270.elb.us-east-1.amazonaws.com/

https://antonputra.com/kubernetes/add-iam-user-and-iam-role-to-eks/
https://www.youtube.com/watch?v=EGdN21F2Jfw&t=21s



