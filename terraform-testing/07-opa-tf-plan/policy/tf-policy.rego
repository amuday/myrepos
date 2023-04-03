package main

import input as tfplan


# deny[msg]{
#     r := tfplan.resource_changes[_]
#     r.type == "azurerm_network_security_group"

#     ports := r.change.after.security_rule[_].destination_port_range 
#     msg := sprintf("port is %v", [ports])
# }

deny[msg]{
    r := tfplan.resource_changes[_]
    r.type == "azurerm_network_security_group"
    r.change.after.security_rule[_].source_address_prefix == "*"
    msg := sprintf("%v has 0.0.0.0/0 as allowed ingress", [r.address])
}





# deny[msg]{
#     nsg := get_resource_by_type_and_name(tfplan.resource_changes, "azurerm_network_security_group")

#     msg := sprintf("messages", [nsg])

# }