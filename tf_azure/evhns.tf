resource "azurerm_eventhub_namespace" "evhns001" {
  name                = "evhns-${var.workload}-${var.environment}-${var.region["short"]}001"
  location            = var.region["location"]
  resource_group_name = azurerm_resource_group.rsg001.name
  sku                 = "Standard"
  capacity            = 1
  network_rulesets {
    default_action                 = "Deny"
    trusted_service_access_enabled = true
    virtual_network_rule {
      subnet_id = azurerm_subnet.snt001.id
    }
  }
}

resource "azurerm_eventhub" "evh001" {
  name                = "evh-${var.workload}-${var.environment}-${var.region["short"]}-001"
  namespace_name      = azurerm_eventhub_namespace.evhns001.name
  resource_group_name = azurerm_resource_group.rsg001.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_namespace_authorization_rule" "evhar001" {
  name                = var.workload
  namespace_name      = azurerm_eventhub_namespace.evhns001.name
  resource_group_name = azurerm_resource_group.rsg001.name
  listen              = true
  send                = true
  manage              = false
}
