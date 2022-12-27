resource "azurerm_route_table" "firewallroutetable" {
  name                          = "firewall-route-table"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  disable_bgp_route_propagation = true

}

resource "azurerm_route" "firewallroute" {
  name                   = "acceptanceTestRoute1"
  resource_group_name    = azurerm_resource_group.this.name
  route_table_name       = azurerm_route_table.firewallroutetable.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.appfirewall.ip_configuration[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "subnetassociation" {
  subnet_id      = azurerm_subnet.subnetA.id
  route_table_id = azurerm_route_table.firewallroutetable.id
}