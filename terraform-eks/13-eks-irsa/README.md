Working as expected 

objective:
    list S3 buckets to show case how to access AWS services from EKS private subnets.
        Create an IAM Role and IAM policy
        Federated identities using OIDC
        EKS cluster used as identity provider
            Create a Service Account
            Annotate service account with aws_iam_role.irsa_iam_role.arn
        Temporary credentials are provided to access s3 bucket

EKS JWT token -> AWS Federated -> JWT to STS -> STS will send temporary credential -> Access AWS Services

verify 
    IAM -> Identity providers
           Audience
           Thumbprints

# Configure kubeconfig for kubectl
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
aws eks --region us-east-1 update-kubeconfig --name hr-dev-eksdemo1         


# Verify Kubernetes Worker Nodes using kubectl
kubectl get nodes
kubectl get nodes -o wide

# Get OpenID Connect provider URL for EKS Cluster
Go to Services -> EKS -> hr-dev-eksdemo1 -> overview -> OpenID Connect provider URL

https://oidc.eks.us-east-1.amazonaws.com/id/9696320B0EF08FA80B0DF0367AD9646D

# EKS OpenID Connect Well Known Configuration URL
<EKS OpenID Connect provider URL>/.well-known/openid-configuration

# Sample
https://oidc.eks.us-east-1.amazonaws.com/id/9696320B0EF08FA80B0DF0367AD9646D/.well-known/openid-configuration


## 2.0 K8S resources

# Verify Kubernetes Service Account
kubectl get sa
kubectl describe sa irsa-demo-sa
Observation:
1. We can see that IAM Role ARN is associated in Annotations field of Kubernetes Service Account

# List & Describe Kubernetes Jobs
kubectl get job
kubectl describe job irsa-demo
Observation:
1. You should see COMPLETIONS 1/1
2. You should see when you describe Pods Statuses:  0 Running / 1 Succeeded / 0 Failed

# Verify Logs (by giving job label app=irsa-demo)
kubectl logs -f -l app=irsa-demo
Observation: 
1. You can see all the S3 buckets from your AWS account listed