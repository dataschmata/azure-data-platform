resource "azurerm_eventhub_namespace" "ehn100" {
  name                = "ehn-${local.name_conv}-100"
  location            = var.region["location"]
  resource_group_name = azurerm_resource_group.rsg_main.name
  sku                 = "Standard"
  capacity            = 1
  network_rulesets {
    default_action                 = "Deny"
    trusted_service_access_enabled = true
    virtual_network_rule {
      subnet_id = azurerm_subnet.snt_main.id
    }
  }
}

resource "azurerm_eventhub" "evh001" {
  name                = "evh-${local.name_conv}-100"
  namespace_name      = azurerm_eventhub_namespace.ehn100.name
  resource_group_name = azurerm_resource_group.rsg_main.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_namespace_authorization_rule" "ehr100" {
  name                = var.workload
  namespace_name      = azurerm_eventhub_namespace.ehn100.name
  resource_group_name = azurerm_resource_group.rsg_main.name
  listen              = true
  send                = true
  manage              = false
}
