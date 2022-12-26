# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}


resource "azurerm_service_plan" "primaryplan" {
  name                = "primaryplan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "primaryapp" {
  name                = "primaryapp${random_integer.ri.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.primaryplan.id

  site_config {
    always_on = false
    application_stack {
      python_version = "3.10"
    }
  }

}

# Creation of the secondary web app

resource "azurerm_service_plan" "secondaryplan" {
  name                = "secondaryplan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "secondaryapp" {
  name                = "secondaryapp${random_integer.ri.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.secondaryplan.id

  site_config {
    always_on = false
    application_stack {
      node_version = "16-lts"
    }
  }

}