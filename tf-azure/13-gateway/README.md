# Gateway
    URL based routing
    Request is routed to corresponding backend pool

# Manual setup
    Create 2 VMs (DS1_v2 only working with userdata)
    Create an empty subnet within the virtual network
    create application gateway 
        select the empty subnet
        in the frontends, create a new public IP address
        in the backends
            Add the backend pool for app1 (Target type virtual machine and select app1 network interface)
            Add the backend pool for app2 (Target type virtual machine and select app2 network interface)
        Routing rules
            Add listener rules
            Add backend rules
                backend target : app1
                Add new backend settings
            Pathbased routing
                Add multiple targets to create a path-based rule


# Manual verification
    wait for gateway creation
    Access gateway IP address
        http://20.127.56.76/app1/metadata.html
        http://20.127.56.76/app2/metadata.html
        http://20.127.56.76/app1
        http://20.127.56.76/app2
        http://20.127.56.76

# Terraform
    Apply terraform
    Get gateway public url
        http://20.115.112.222/
        http://20.115.112.222/app1/
        http://20.115.112.222/app1/metadata.html

        http://20.115.112.222/app2/hostname.html
        http://20.115.112.222/app2/status.html
        http://20.115.112.222/app2/metadata.html