resource "azurerm_databricks_workspace" "dbw001" {
  name                = "dbw-${var.workload}-${var.environment}-${var.region["short"]}-001"
  resource_group_name = azurerm_resource_group.rsg001.name
  location            = var.region["location"]
  sku                 = "standard"

}