resource "azurerm_public_ip" "lbip" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  # its needed for production as by default basic load balancer will be deployed.
  sku = "Standard"
}

resource "azurerm_lb" "this" {
  name                = "TestLoadBalancer"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  # its needed for production as by default basic load balancer will be deployed.
  sku      = "Standard"
  sku_tier = "Regional"

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.lbip.id
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "BackEndAddressPool"
}


resource "azurerm_lb_probe" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "helath-probe"
  port            = 80
  protocol        = "Tcp"
}


resource "azurerm_lb_rule" "this" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "LBRuleA"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
}