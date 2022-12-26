
resource "azurerm_virtual_network_peering" "peering-1" {
  name                      = "stagingtotest"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.this["staging"].name
  remote_virtual_network_id = azurerm_virtual_network.this["test"].id
}

resource "azurerm_virtual_network_peering" "peering-2" {
  name                      = "tsesttostaging"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.this["test"].name
  remote_virtual_network_id = azurerm_virtual_network.this["staging"].id
}