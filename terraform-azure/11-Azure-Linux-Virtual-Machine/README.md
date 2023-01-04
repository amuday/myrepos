Its a continuation of previous project

# Create in this project
config files (c7-01 to c7-06)
1. Public IP
    To access the VM from outside. 
    A public IP address enables you to communicate to a VM from the internet. 
    Assign a static public IP address, rather than a dynamic address, to ensure the address never changes.
2. Network interface (NIC)
3. Virtual machine (VM)
    Azure disk is created automatically when VM is created
4. NSG for the NIC
    its secong level security. First one is NSG at subnet level.
    azurerm_network_interface_security_group_association
    open port 22 for ssh

# validation
verify below resources
1. public IP: hr-dev-web-linuxvm-publicip
    DNS name
2. NIC: hr-dev-web-linuxvm-nic
    private IP
    Network security group   
3. Global search -> NSG
    hr-dev-web-linuxvm-nic-nsg
    NSG <-> NIC (both way connection)
4. VM: hr-dev-web-linuxvm
    Operating system...
    settings -> networking
    2 NSGs are applied to the vm *****
        hr-dev-vnet-websubnet-nsg (subnet nsg)
        hr-dev-web-linuxvm-nic-nsg (nic nsg)
    Topology
        your vm -> networking -> topology
5. SSH into the VM
    sudo su -
    cd /var/log
    ls
    cat cloud-init-output.log
    cat cloud-init.log
    netstat -lntp

    cd /var/www/html/
    ls

    # webserver logs
        cd /var/log/httpd
        cat error_log
        cat access_log
    Access in browser and see logs are captured for the new events
    
6. From browser
    With public IP
        http://4.246.222.237/app1/metadata.html
        http://4.246.222.237/app1
        http://4.246.222.237

    with DNS
        http://app1-vm-jyfprs.eastus.cloudapp.azure.com/


