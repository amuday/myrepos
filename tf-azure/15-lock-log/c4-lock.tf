
/*
resource "azurerm_management_lock" "vm-lock" {
  name       = "vm-lock"
  scope      = azurerm_linux_virtual_machine.this.id
  lock_level = "ReadOnly"
  notes      = "No changes should be made to the virtual machine!"
}

*/