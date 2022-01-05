resource "azurerm_eventhub_namespace" "evhns001" {
  name                = "evhns-das-dev-westeu-001"
  location            = azurerm_resource_group.rsg001.location
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
  name                = "evh-das-dev-westeu-001"
  namespace_name      = azurerm_eventhub_namespace.evhns001.name
  resource_group_name = azurerm_resource_group.rsg001.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "evhar001" {
  name                = "das"
  namespace_name      = azurerm_eventhub_namespace.evhns001.name
  eventhub_name       = azurerm_eventhub.evh001.name
  resource_group_name = azurerm_resource_group.rsg001.name
  listen              = true
  send                = true
  manage              = false
}
