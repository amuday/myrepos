resource "azurerm_resource_group" "this" {
  name     = var.resource_group
  location = var.location
}


resource "azurerm_virtual_network" "this" {
  for_each            = var.environment
  name                = "${each.key}-network"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [each.value]

  subnet {
    name = "${each.key}subnet"
    # 8 will be added to subnet mask 16 and it will be /24
    address_prefix = cidrsubnet(each.value, 8, 0)
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.environment
  name                = "${each.key}-nsg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "nsg-link" {
  for_each                  = var.environment
  subnet_id                 = azurerm_virtual_network.this[each.key].subnet.*.id[0]
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

