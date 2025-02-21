resource "azurerm_resource_group" "this" {
  name     = "st-kv-rg"
  location = "East US"
}

data "azurerm_client_config" "current" {}



resource "azurerm_user_assigned_identity" "this" {
  name                = "st-cmk-identity"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_key_vault" "this" {
  name                        = "kvtest14feb25"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  enable_rbac_authorization   = true
  sku_name                    = "standard"

}

resource "azurerm_role_assignment" "this" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "msi" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_key_vault_key" "this" {
  name         = "st-cmk-key1"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }

  depends_on = [azurerm_role_assignment.this, azurerm_role_assignment.msi]
}


## Below code works fine but it will use only speific version of key

/*
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
*/

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
    #key_vault_key_id          = join("/", slice(split("/", azurerm_key_vault_key.this.id), 0, length(split("/", azurerm_key_vault_key.this.id)) - 1))
    key_vault_key_id          = azurerm_key_vault_key.this.versionless_id
    user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  }
}


# below code will use latest version of key

/*
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
*/

output "key_vault_key_id" {
  value = azurerm_key_vault_key.this.id
}

output "key_vault_key_version" {
  value = azurerm_key_vault_key.this.version
}

output "key_vault_key_name" {
  value = azurerm_key_vault_key.this.name
}