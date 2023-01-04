Working without any issue.

https://github.com/amuday/terraform-on-azure-cloud/tree/main/10-Azure-Virtual-Network-4Tier

check variables in terraform.tfvars

1. Create a resouce group (rg)
2. Inside the rg create a virtual network (vnet)
3. Inside the vnet create below subnets and corresponding network security groups (NSG)
    web tier
    app tier
    db tier
    bastion host
4. create a NSG. NSG rules can be created 2 ways, inline and standalone. Here we follow standalone.
    Associate NSG with Subnet
    Create NSG rules and map it with NSG

# validation
    1. Azure Resource Group
    2. Azure Virtual Network
        Address space
        Subnets
    3. Azure Subnets (Web, App, DB, Bastion)
    4. Azure Network Security Groups (Web, App, DB, Bastion)
        global search NSG -> click on each NSG to see the rules
    5. View the topology
        virtual network -> Diagram
    6. Verify Terraform Outputs in Terraform CLI