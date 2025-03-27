resource "azurerm_public_ip" "gatewayip" {
  name                = "gateway-ip"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
  #sku_tier            = "Regional"
  zones = var.zones
}

# We need an additional subnet in the virtual network
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "gateway-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_application_gateway" "this" {
  name                = "app-gateway"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  zones = var.zones

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.gateway_subnet.id
  }

  frontend_port {
    name = "front-end-port"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "front-end-ip-config"
    public_ip_address_id = azurerm_public_ip.gatewayip.id
  }

  dynamic "backend_address_pool" {
    for_each = toset(var.function)
    content {
      name = "${backend_address_pool.value}-pool"
      ip_addresses = [
        "${azurerm_network_interface.interface[backend_address_pool.value].private_ip_address}"
      ]
    }
  }

  backend_http_settings {
    name                  = "HTTPSetting"
    cookie_based_affinity = "Disabled"
    path                  = ""
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "gateway-listener"
    frontend_ip_configuration_name = "front-end-ip-config"
    frontend_port_name             = "front-end-port"
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_cert_name
  }

  request_routing_rule {
    name               = "RoutingRuleA"
    rule_type          = "PathBasedRouting"
    url_path_map_name  = "RoutingPath"
    http_listener_name = "gateway-listener"
    priority           = 1
  }

  url_path_map {
    name                               = "RoutingPath"
    default_backend_address_pool_name  = "${var.function[0]}-pool"
    default_backend_http_settings_name = "HTTPSetting"

    dynamic "path_rule" {
      for_each = toset(var.function)
      content {
        name                       = "${path_rule.value}RoutingRule"
        backend_address_pool_name  = "${path_rule.value}-pool"
        backend_http_settings_name = "HTTPSetting"
        paths = [
          "/${path_rule.value}/*",
        ]
      }
    }
  }

  #### Add User assigned identity
  identity {
    type         = "UserAssigned"
    #identity_ids = [var.user_assigned_identity]
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  # Add key vaut id
  ssl_certificate {
    name                = var.ssl_cert_name
    #key_vault_secret_id = var.kv_scret_id
    key_vault_secret_id = azurerm_key_vault_certificate.this.secret_id
  }
}

