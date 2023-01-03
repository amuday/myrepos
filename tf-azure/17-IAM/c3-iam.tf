resource "azuread_user" "user2" {
  user_principal_name = "testuser2@udaykumaramoutlook.onmicrosoft.com"
  display_name        = "Test User2"
  mail_nickname       = "user2"
  password            = "SecretP@sswd99!"
}

resource "azurerm_role_assignment" "reader_role" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Reader"
  principal_id         = azuread_user.user2.object_id
}

data "azurerm_subscription" "primary" {
}

resource "azurerm_role_definition" "custom_role" {
  name        = "my-custom-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions = ["Microsoft.Compute/*/read",
      "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/restart/action"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}

resource "azurerm_role_assignment" "custom_role" {
  scope                = azurerm_resource_group.this.id
 # role_definition_name = "custom_role"
  role_definition_name  = azurerm_role_definition.custom_role.name
  principal_id         = azuread_user.user2.object_id
}