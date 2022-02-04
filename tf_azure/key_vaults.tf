resource "azurerm_key_vault" "kvt_main" {
  name                        = local.kvt_main
  location                    = var.region["location"]
  resource_group_name         = azurerm_resource_group.rsg_main.name
  enabled_for_disk_encryption = true
  tenant_id                   = local.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
  tags                        = local.tags
  sku_name                    = "standard"

  network_acls {
    # Set to Allow due to runner ip change
    default_action = "Allow"
    ip_rules       = [chomp(data.http.myip.body)]
    bypass         = "AzureServices"
    # de-activating due to runner ip change
    # virtual_network_subnet_ids = [
    #   azurerm_subnet.snt_main.id,
    # ]
  }
}