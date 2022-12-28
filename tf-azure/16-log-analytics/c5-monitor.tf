resource "azurerm_monitor_action_group" "email_alert" {
  name                = "email-alert"
  resource_group_name = azurerm_resource_group.this.name
  short_name          = "email-alert"

  email_receiver {
    name                    = "send-email-alert"
    email_address           = "udaythird@gmail.com"
    use_common_alert_schema = true
  }
}


# alert based on metric
resource "azurerm_monitor_metric_alert" "Network_threshold_alert" {
  name                = "Network-threshold-alert"
  resource_group_name = azurerm_resource_group.this.name
  scopes              = [azurerm_linux_virtual_machine.this.id]
  description         = "The alert will be sent if the  Network Out bytes exceeds 70 bytes"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Network Out Total"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 70

  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }

}

# alert based on activity log
resource "azurerm_monitor_activity_log_alert" "virtual_machine_operation" {
  name                = "virtual-machine-operation"
  resource_group_name = azurerm_resource_group.this.name
  scopes              = [azurerm_resource_group.this.id]
  description         = "This alert will be sent if the virtual machine is deallocated"

  criteria {
    resource_id    = azurerm_linux_virtual_machine.this.id
    operation_name = "Microsoft.Compute/virtualMachines/deallocate/action"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_alert.id
  }

}