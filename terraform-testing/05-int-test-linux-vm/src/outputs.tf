output "vm_name" {
  value = azurerm_linux_virtual_machine.this.name
}

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}