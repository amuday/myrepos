# Bastion host and bastion Service

Old approach (Bastion host)
  SSH on port 22 -> Bastion host -> VM
Bastion service (Azure Recommended) - PaaS service
  Browser (TLS-port 443) -> Bastion service -> VM
  Costly
  cant start and stop the service

# Validation
  hr-dev-vnet -> Diagram -> Bastion subnet is added
  Web VM does not have public IP
  
# SSH into bastion host 
    verify pem file in /tmp dir
    connect to Web VM
      [root@hr-dev-bastion-linuxvm ~]# ssh -i /tmp/terraform-azure.pem azureuser@10.1.1.4    
      [azureuser@hr-dev-web-linuxvm ~]$

# Bastion service valiadtion
  Global serach Bastions -> hr-dev-bastion-service -> Sessions -> there is no session
                                                   -> configurations
                                                   -> properties
  VM: hr-dev-web-linuxvm -> connect -> Bastion -> use bastion -> user name : azure user and SSH connectivity -> connected to web VM                                                  

    Global serach Bastions -> hr-dev-bastion-service -> Sessions -> there is a session

  Connect to bastion host VM using bastion service. Eventhough bastion vm has public ip, still you will be able to connect using bastion service.


