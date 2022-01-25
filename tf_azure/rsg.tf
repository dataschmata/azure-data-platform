resource "azurerm_resource_group" "rsg_main" {
  name     = locals.rsg_main
  location = var.region["location"]
}
