
data "azurerm_resource_group" "this" {
  name     = "test"
}

import {
    to = azurerm_storage_account.import_example
    id = "/subscriptions/8174109a-86db-4fdb-a978-e4a3657503fa/resourceGroups/test/providers/Microsoft.Storage/storageAccounts/stimportest"
}  


import {
  to = azurerm_storage_account.import_example_2
  id = "/subscriptions/8174109a-86db-4fdb-a978-e4a3657503fa/resourceGroups/test/providers/Microsoft.Storage/storageAccounts/stimportest2"

}

resource "azurerm_storage_account" "import_example" {
    name                     = "stimportest"
    resource_group_name      = data.azurerm_resource_group.this.name
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    allow_nested_items_to_be_public = false
}

resource "azurerm_storage_account" "import_example_2" {
    name                     = "stimportest2"
    resource_group_name      = data.azurerm_resource_group.this.name
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    allow_nested_items_to_be_public = false
}
