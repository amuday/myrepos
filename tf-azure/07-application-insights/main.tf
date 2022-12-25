
resource "azurerm_resource_group" "this" {
  name     = var.resource_group
  location = var.location
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_service_plan" "this" {
  name                = "service-plan"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  # free tier is F1. check in portal
  sku_name = "S1"
}

resource "azurerm_linux_web_app" "this" {
  name                = "samplewebapp-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_service_plan.this.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = false
    application_stack {
      python_version = "3.10"
    }
  }

   app_settings = {
  "APPINSIGHTS_INSTRUMENTATIONKEY" =azurerm_application_insights.this.instrumentation_key
   "APPLICATIONINSIGHTS_CONNECTION_STRING"=azurerm_application_insights.this.connection_string
}

}
