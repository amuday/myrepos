
resource "tls_private_key" "linuxkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "linuxpemkey" {
  filename = "linuxkey.pem"
  content  = tls_private_key.linuxkey.private_key_pem
  depends_on = [
    tls_private_key.linuxkey
  ]
}


resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = "VirtualMachine-scaleset"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  instances           = var.number_of_machines
  # Not advisable for production, it should be manual or rolling update
  upgrade_mode   = "Automatic"
  sku            = "Standard_DS1_v2"
  admin_username = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.linuxkey.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  network_interface {
    name    = "scaleset-interface"
    primary = true
    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.subnetA.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.this.id]
    }
  }

  custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")

}

