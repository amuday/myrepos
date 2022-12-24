resource "azurerm_resource_group" "rg" {
  # Azure caches resource name, when you create a new resource with same name, it will give issues. its not needed in realtime.
  #name = "${local.resource_name_prefix}-${var.resource_group_name}"
  name     = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  location = var.resource_group_location
  tags     = local.common_tags
}