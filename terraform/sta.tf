resource "azurerm_storage_account" "sta001" {
  name                     = "stadasdevwesteu001"
  resource_group_name      = azurerm_resource_group.rsg001.name
  location                 = azurerm_resource_group.rsg001.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.snt001.id]
  }
}

resource "azurerm_role_assignment" "role001" {
  scope                = azurerm_storage_account.sta001.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.cfg.object_id
}

# resource "azurerm_storage_container" "stc001" {
#   name                  = "hdinsight"
#   storage_account_name  = azurerm_storage_account.sta001.name
#   container_access_type = "private"
#   depends_on            = [azurerm_role_assignment.role001]
# }

resource "azurerm_storage_data_lake_gen2_filesystem" "stf001" {
  name               = "raw"
  storage_account_id = azurerm_storage_account.sta001.id
  depends_on         = [azurerm_role_assignment.role001]
}
