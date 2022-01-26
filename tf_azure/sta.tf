resource "azurerm_storage_account" "sta100" {
  name                     = replace("sta${local.name_conv}100", "-", "")
  resource_group_name      = azurerm_resource_group.rsg_main.name
  location                 = var.region["location"]
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  tags                     = local.tags
  network_rules {
    default_action             = "Deny"
    ip_rules                   = [chomp(data.http.myip.body)]
    virtual_network_subnet_ids = [azurerm_subnet.snt_main.id]
  }
}

resource "azurerm_role_assignment" "role100" {
  scope                = azurerm_resource_group.rsg_main.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.cfg.object_id
}

### known issue https://github.com/hashicorp/terraform-provider-azurerm/issues/2977, usin ARM template as suggested in issue
# resource "azurerm_storage_container" "stc001" {
#   name                  = "hdinsight"
#   storage_account_name  = azurerm_storage_account.sta001.name
#   container_access_type = "private"
#   depends_on            = [azurerm_role_assignment.role001]
# }

# resource "azurerm_storage_data_lake_gen2_filesystem" "stf001" {
#   name               = "raw"
#   storage_account_id = azurerm_storage_account.sta001.id
#   depends_on         = [azurerm_role_assignment.role001]
# }
