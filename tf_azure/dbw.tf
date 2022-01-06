resource "azurerm_databricks_workspace" "dbw001" {
  name                = "dbw-das-dev-westeu-001"
  resource_group_name = azurerm_resource_group.rsg001.name
  location            = azurerm_resource_group.rsg001.location
  sku                 = "standard"

}