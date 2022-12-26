resource "azurerm_traffic_manager_profile" "this" {
  name                   = "profile${random_integer.ri.result}"
  resource_group_name    = azurerm_resource_group.this.name
  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "profile${random_integer.ri.result}"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

}

resource "azurerm_traffic_manager_azure_endpoint" "primaryendpoint" {
  name               = "primaryendpoint"
  profile_id         = azurerm_traffic_manager_profile.this.id
  priority           = 1
  weight             = 100
  target_resource_id = azurerm_linux_web_app.primaryapp.id

  custom_header {
    name  = "host"
    value = "${azurerm_linux_web_app.primaryapp.name}.azurewebsites.net"
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "secondaryendpoint" {
  name               = "secondaryendpoint"
  profile_id         = azurerm_traffic_manager_profile.this.id
  priority           = 2
  weight             = 100
  target_resource_id = azurerm_linux_web_app.secondaryapp.id

  custom_header {
    name  = "host"
    value = "${azurerm_linux_web_app.secondaryapp.name}.azurewebsites.net"
  }
}


resource "azurerm_app_service_custom_hostname_binding" "this" {
  hostname            = azurerm_traffic_manager_profile.this.fqdn
  app_service_name    = azurerm_linux_web_app.primaryapp.name
  resource_group_name = azurerm_resource_group.this.name
  depends_on = [
    azurerm_traffic_manager_azure_endpoint.primaryendpoint
  ]
}
