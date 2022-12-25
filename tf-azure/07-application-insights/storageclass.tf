resource "random_string" "random" {
  length  = 10
  lower   = true
  numeric = true
  special = false
  upper   = false
}

resource "azurerm_storage_account" "this" {
  name                     = "mysta${random_string.random.id}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # below is default storage
  account_kind = "StorageV2"
}


resource "azurerm_storage_container" "this" {
  name                  = "logs"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}

/*
Use this data source to obtain a Shared Access Signature (SAS Token) for an existing Storage Account Blob Container.
Shared access signatures allow fine-grained, ephemeral access control to various aspects of an Azure Storage Account Blob Container.

*/

data "azurerm_storage_account_blob_container_sas" "accountsas" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.this.name
  https_only        = true

  start  = "2022-12-24"
  expiry = "2023-01-30"

  permissions {
    read   = true
    add    = true
    create = false
    write  = true
    delete = true
    list   = true
  }
}

output "sas" {
  value = nonsensitive("https://${azurerm_storage_account.this.name}.blob.core.windows.net/${azurerm_storage_container.this.name}${data.azurerm_storage_account_blob_container_sas.accountsas.sas}")
}