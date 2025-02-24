#--------------
# Locals Block
#-------------
locals {
  image_timestamp       = formatdate("YYYY-MM-DD", timestamp())
  jira_image_name = "${var.appname}-${var.env}-v${var.image_timestamp}-${formatdate("YYMMDDmm", timestamp())}"
}

#--------------
# Source Block
#-------------
source "azure-arm" "shared_image" {
  client_id                           = var.client_id
  client_secret                       = var.client_secret
  tenant_id                           = var.tenant_id
  subscription_id                     = var.subscription_id
  os_type                             = var.os_type
  vm_size                             = var.vm_size
  build_resource_group_name           = var.build_resource_group_name
  virtual_network_name                = var.virtual_network_name
  virtual_network_subnet_name         = var.virtual_network_subnet_name
  virtual_network_resource_group_name = var.virtual_network_resource_group_name
  ssh_username                        = var.ssh_username
  ssh_password                        = var.ssh_password
  disk_additional_size                = [500]
  disk_encryption_set_id              = var.disk_encryption_set_id

  shared_image_gallery {
    subscription   = var.sub1_subscription_id
    resource_group = var.sub1_gallery_resource_group_name
    gallery_name   = var.sub1_gallery_name
    image_name     = var.sub1_image_name
    image_version  = var.sub1_image_version
  }


  shared_image_gallery_destination {
    subscription         = var.subscription_id
    resource_group       = var.resource_group_name
    gallery_name         = var.gallery_name
    image_name           = var.image_name
    image_version        = var.image_version
    storage_account_type = var.storage_account_type
    
    target_region {
      name                   = var.target_region
      disk_encryption_set_id = var.disk_encryption_set_id
    } 
  }

  managed_image_name                = null
  managed_image_resource_group_name = null

}

build {
  name    = "jira"
  sources = ["source.azure-arm.shared_image"]
  provisioner "ansible" {
    user          = var.username
    use_proxy     = "false"
    playbook_file = "./gen-helper.yml"
    extra_arguments = [
      "${var.ansible_debug_level}",
      "--extra-vars",
      "appslot=${var.appslot} rds_engine_type=${var.rds_engine_type} app_discover_method=${var.app_discover_method} app_edition=${var.app_edition} elasity_prefix=${var.elasity_prefix} appname=${var.appname} remote_tmp=/var/tmp/${var.username}/ansible",
    ]
  }
  
  provisioner "ansible" {
    user          = var.username
    use_proxy     = "false"
    playbook_file = "./app0-install.yml"
    extra_arguments = [
      "${var.ansible_debug_level}",
      "--extra-vars",
      "appslot=${var.appslot} rds_engine_type=${var.rds_engine_type} app_discover_method=${var.app_discover_method} app_edition=${var.app_edition} elasity_prefix=${var.elasity_prefix} appname=${var.appname} remote_tmp=/var/tmp/${var.username}/ansible",
      "-e",
      "{\"jira_pe_ips\": ${jsonencode(var.jira_pe_ips)}}",
    ]
  }
}

#-----------------
# Define Variables
#-----------------
variable "image_timestamp" {
  type    = string
  default = ""
}
variable "jira_image_name" {
  type    = string
  default = ""
}
variable "disk_additional_size" {
  type    = string
  default = ""
}
variable "ansible_debug_level" {
  type    = string
  default = "-vv"
}
variable "username" {
  type    = string
  default = ""
}
variable "sub1_gallery_name" {
  type    = string
  default = ""
}
variable "sub1_image_name" {
  type    = string
  default = ""
}
variable "sub1_image_version" {
  type    = string
  default = ""
}
variable "sub1_gallery_resource_group_name" {
  type    = string
  default = ""
}
variable "sub1_subscription_id" {
  type    = string
  default = ""
}
variable "client_id" {
  type    = string
  default = ""
}
variable "tenant_id" {
  type    = string
  default = ""
}
variable "client_secret" {
  type    = string
  default = ""
}
variable "location" {
  type    = string
  default = ""
}
variable "subscription_id" {
  type    = string
  default = ""
}
variable "virtual_network_name" {
  type    = string
  default = ""
}
variable "virtual_network_subnet_name" {
  type    = string
  default = ""
}
variable "virtual_network_resource_group_name" {
  type    = string
  default = ""
}
variable "managed_image_name" {
  type    = string
  default = ""
}
variable "managed_image_resource_group_name" {
  type    = string
  default = ""
}
variable "os_type" {
  type    = string
  default = ""
}
variable "image_publisher" {
  type    = string
  default = ""
}
variable "image_offer" {
  type    = string
  default = ""
}
variable "image_sku" {
  type    = string
  default = ""
}
variable "vm_size" {
  type    = string
  default = ""
}
variable "communicator" {
  type    = string
  default = ""
}
variable "ssh_username" {
  type    = string
  default = ""
}
variable "ssh_password" {
  type    = string
  default = ""
}
variable "ssh_timeout" {
  type    = string
  default = ""
}
variable "build_resource_group_name" {
  type    = string
  default = ""
}
variable "resource_group_name" {
  type    = string
  default = ""
}
variable "custom_managed_image_name" {
  type    = string
  default = ""
}
variable "custom_managed_image_resource_group_name" {
  type    = string
  default = ""
}
variable "custom_managed_image_location" {
  type    = string
  default = ""
}

variable "disk_encryption_set_id" {
  type    = string
  default = ""
}

variable "gallery_name" {
  type    = string
  default = ""
}

variable "image_name" {
  type    = string
  default = ""
}

variable "image_version" {
  type    = string
  default = ""
}

variable "storage_account_type" {
  type    = string
  default = ""
}

variable "target_region" {
  type    = string
  default = ""
}

#-------------
# APP variables
#-------------
variable "appslot" {
  type    = string
  default = ""
}
variable "rds_engine_type" {
  type    = string
  default = ""
}
variable "app_discover_method" {
  type    = string
  default = ""
}
variable "env" {
  type    = string
  default = ""
}
variable "app_edition" {
  type    = string
  default = ""
}
variable "elasity_prefix" {
  type    = string
  default = ""
}
variable "appname" {
  type    = string
  default = ""
}

variable "jira_pe_ips" {
  type    = list(string)
  default = []
}