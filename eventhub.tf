resource "azurerm_eventhub" "evh100" {
  name                = "evh-${local.name_conv}-100"
  namespace_name      = azurerm_eventhub_namespace.ehn100.name
  resource_group_name = azurerm_resource_group.rsg_main.name
  partition_count     = 2
  message_retention   = 1
}
