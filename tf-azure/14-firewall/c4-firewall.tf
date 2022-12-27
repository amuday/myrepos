# First we need to create a Public IP address for the Azure Firewall

resource "azurerm_public_ip" "firewallip" {
  name                = "firewall-ip"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"

}

# We need an additional subnet in the virtual network
resource "azurerm_subnet" "firewallsubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_firewall_policy" "firewallpolicy" {
  name                = "firewallpolicy"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

resource "azurerm_firewall" "appfirewall" {
  name                = "appfirewall"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewallsubnet.id
    public_ip_address_id = azurerm_public_ip.firewallip.id
  }

  sku_tier = "Standard"
  sku_name = "AZFW_VNet"

  firewall_policy_id = azurerm_firewall_policy.firewallpolicy.id

}