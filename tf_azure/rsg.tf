resource "azurerm_resource_group" "rsg_main" {
  name     = local.rsg_main
  location = var.region["location"]
  tags     = local.tags
}
