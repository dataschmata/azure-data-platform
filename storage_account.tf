resource "azurerm_storage_account" "sta100" {
  name                      = local.sta_main
  resource_group_name       = azurerm_resource_group.rsg_main.name
  location                  = var.region["location"]
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  is_hns_enabled            = true
  enable_https_traffic_only = true
  access_tier               = "Hot"
  allow_blob_public_access  = false
  min_tls_version           = "TLS1_2"
  tags                      = local.tags
  network_rules {
    default_action = "Deny"
    ip_rules       = [chomp(data.http.myip.body)]
    bypass         = ["Logging", "AzureServices", "Metrics"]
    virtual_network_subnet_ids = [
      azurerm_subnet.snt_main.id,
    ]
  }
}

resource "azurerm_advanced_threat_protection" "atp100" {
  target_resource_id = azurerm_storage_account.sta100.id
  enabled            = true
}

# resource "azurerm_private_endpoint" "pep_sta100" {
#   name                = "pep-snt100-sta100-${local.name_conv}"
#   location            = var.region["location"]
#   resource_group_name = azurerm_resource_group.rsg_main.name
#   subnet_id           = azurerm_subnet.snt_main.id
#   tags                = local.tags
#   private_service_connection {
#     name                           = "pep-snt100-sta100-${local.name_conv}"
#     private_connection_resource_id = azurerm_storage_account.sta100.id
#     subresource_names              = ["dfs"]
#     is_manual_connection           = false
#   }
# }

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
