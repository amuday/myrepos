resource "azurerm_resource_group" "this" {
  name     = var.resource_group
  location = var.location
}
