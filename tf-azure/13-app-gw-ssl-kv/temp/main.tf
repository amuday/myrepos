data "azurerm_key_vault" "this" {
  name                = "ukamappgwkv"
  resource_group_name = "kv-rg"
}

data "azurerm_key_vault_certificate" "this" {
  name         = "app-gw-version-1"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_certificates" "this" {
  key_vault_id = data.azurerm_key_vault.this.id
}


output "azurerm_key_vault" {
  value = data.azurerm_key_vault.this
}

output "azurerm_key_vault_certificate" {
  value = data.azurerm_key_vault_certificate.this.secret_id
}

output "azurerm_key_vault_certificates" {
  value = data.azurerm_key_vault_certificates.this
}

output "azurerm_key_vault_certificates_ids" {
  value = data.azurerm_key_vault_certificates.this.certificates.*.id
}

output "azurerm_key_vault_certificates_names" {
  value = data.azurerm_key_vault_certificates.this.certificates.*.name
}
