resource "azurerm_log_analytics_workspace" "vmworkspace" {
  name                = "vmworkspace30049"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_virtual_machine_extension" "vmagent" {
  name                 = "vmagent"
  virtual_machine_id   = azurerm_linux_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Extensions"
  
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "commandToExecute": "hostname && uptime"
 }
SETTINGS


  /*
  type                 = "MicrosoftMonitoringAgent"
  type_handler_version = "1.0"

  auto_upgrade_minor_version = "true"
  settings                   = <<SETTINGS
    {
      "workspaceId": "${azurerm_log_analytics_workspace.vmworkspace.workspace_id}"
    }
SETTINGS
  protected_settings         = <<PROTECTED_SETTINGS
   {
      "workspaceKey": "${azurerm_log_analytics_workspace.vmworkspace.primary_shared_key}"
   }
PROTECTED_SETTINGS
*/

}

resource "azurerm_log_analytics_datasource_windows_event" "systemevents" {
  name                = "systemevents"
  resource_group_name = azurerm_resource_group.this.name
  workspace_name      = azurerm_log_analytics_workspace.vmworkspace.name
  event_log_name      = "System"
  event_types         = ["Information"]
}