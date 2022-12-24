
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

  logs {
    detailed_error_messages = true
    http_logs {
      azure_blob_storage {
        retention_in_days = 7
        sas_url           = "https://${azurerm_storage_account.this.name}.blob.core.windows.net/${azurerm_storage_container.this.name}${data.azurerm_storage_account_blob_container_sas.accountsas.sas}"
      }
    }
  }

}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id   = azurerm_linux_web_app.this.id
  repo_url = "https://github.com/amuday/python-docs-hello-world"
  branch   = "master"
}