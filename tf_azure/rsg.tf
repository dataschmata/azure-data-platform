resource "azurerm_resource_group" "rsg001" {
  name     = "rsg-${var.workload}-${var.environment}-${var.region["short"]}-001"
  location = var.region["location"]
}
