resource "azurerm_databricks_workspace" "dbw100" {
  name                = "dbw-${local.name_conv}-100"
  resource_group_name = azurerm_resource_group.rsgmain.name
  location            = var.region["location"]
  sku                 = "standard"

}