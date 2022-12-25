resource "azurerm_dns_zone" "publiczone" {
  name                = "devopsdemo.tk"
  resource_group_name = azurerm_resource_group.this.name
}

output "server_names"{
  value=azurerm_dns_zone.publiczone.name_servers
}

// Pointing the domain name to the load balancer
resource "azurerm_dns_a_record" "load_balancer_record" {
  name                = "www"
  zone_name           = azurerm_dns_zone.publiczone.name
  resource_group_name = azurerm_resource_group.this.name
  ttl                 = 360
  records             = [azurerm_public_ip.lbip.ip_address]
}