
resource "azurerm_resource_group" "this" {
  name     = "pip-test-rg"
  location = "East US"
}

resource "azurerm_public_ip" "this" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku = "Standard"
  sku_tier = "Regional"
  zones = ["1", "2", "3"]
}