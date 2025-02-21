
# Below code uses specific key version 
```
resource "azurerm_storage_account" "this" {
  name                     = "stkvtest14feb25"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  customer_managed_key {
    key_vault_key_id          = azurerm_key_vault_key.this.id
    user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  }
}
```
![image](images/with%20CMK%20block.png)

# Below codes use latest key version 

## option 1:
```
resource "azurerm_storage_account" "this" {
  name                     = "stkvtest14feb2511"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  customer_managed_key {
    key_vault_key_id          = join("/", slice(split("/", azurerm_key_vault_key.this.id), 0, length(split("/", azurerm_key_vault_key.this.id)) - 1))
    user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  }
}
```

## option 2: 
```
resource "azurerm_storage_account" "this" {
  name                     = "stkvtest14feb25"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

customer_managed_key {
    key_vault_key_id          = azurerm_key_vault_key.this.id
    user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  storage_account_id = azurerm_storage_account.this.id
  key_vault_id       = azurerm_key_vault.this.id
  key_name           = azurerm_key_vault_key.this.name
  user_assigned_identity_id = azurerm_user_assigned_identity.this.id
}
```
![image](images/with%20CMK%20resource.png)