
resource "azurerm_firewall_policy_rule_collection_group" "rulecollection" {
  name               = "rulecollection"
  firewall_policy_id = azurerm_firewall_policy.firewallpolicy.id
  priority           = 500

  nat_rule_collection {
    name     = "nat_rule_collection1"
    priority = 300
    action   = "Dnat"
    rule {
      name                = "AllowSSH"
      protocols           = ["TCP"]
      source_addresses    = ["0.0.0.0/0"]
      destination_address = azurerm_public_ip.firewallip.ip_address
      destination_ports   = ["4000"]
      translated_address  = azurerm_network_interface.appinterface.private_ip_address
      translated_port     = "22"
    }
  }

  application_rule_collection {
    name     = "apprulecollection"
    priority = 600
    action   = "Allow"
    rule {
      name = "AllowHttp"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["${azurerm_network_interface.appinterface.private_ip_address}"]
      destination_fqdns = ["www.microsoft.com"]
    }
  }

}