data "azurerm_key_vault_certificate" "this" {
  count       = length(var.ssl_certs)
  name         = var.ssl_certs[count.index]
  key_vault_id = "/subscriptions/8174109a-86db-4fdb-a978-e4a3657503fa/resourceGroups/test-rg/providers/Microsoft.KeyVault/vaults/mytestukkv"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate
output "kv_ssl_certs_ids" {
  value = [for cert in data.azurerm_key_vault_certificate.this : cert.secret_id]  
}

output "kv_ssl_certs_versionless_secret_ids" {
  value = [for cert in data.azurerm_key_vault_certificate.this : cert.versionless_secret_id ]  
}

 