
resource "azurerm_linux_web_app_slot" "staging" {
  name           = "staging"
  app_service_id = azurerm_linux_web_app.this.id

  site_config {
    always_on = false
    application_stack {
      python_version = "3.10"
    }
  }
}

resource "azurerm_web_app_active_slot" "staging" {
  slot_id = azurerm_linux_web_app_slot.staging.id

}