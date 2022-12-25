resource "azurerm_availability_set" "appset" {
  name                         = "app-set"
  location                     = azurerm_resource_group.this.location
  resource_group_name          = azurerm_resource_group.this.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 3
}