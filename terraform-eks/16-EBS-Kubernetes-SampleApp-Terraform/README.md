Working as expected. 

Container Storage Interface (CSI) driver allows EKS clusters to manage the life cycle of EBS volumes.
EBS CSI driver deployment options
    self managed add-on (Terraform Helm provider)
    EKS add-on (Terraform EKS addon resource)

IRSA is needed. 
CSI controller deployed pods will have access to mange EBS volumes.
