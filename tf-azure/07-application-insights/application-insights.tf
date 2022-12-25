resource "azurerm_log_analytics_workspace" "this" {
  name                = "appworkspace${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_service_plan.this.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "this" {
  name                = "appinsights${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_service_plan.this.location
  application_type    = "web"
  workspace_id = azurerm_log_analytics_workspace.this.id
}