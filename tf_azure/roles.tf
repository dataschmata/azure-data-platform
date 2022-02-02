
resource "azurerm_role_assignment" "role_dbw_adm" {
  scope                = azurerm_storage_account.sta100.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_group.grp_adm_dbw.object_id
}

resource "azurerm_role_assignment" "role_rsg_adm" {
  scope                = azurerm_resource_group.rsg_main.id
  role_definition_name = "Owner"
  principal_id         = azuread_group.grp_adm.object_id
}


#########################
# Databricks
#########################

resource "azurerm_role_assignment" "role_dbw_own" {
  scope                = azurerm_databricks_workspace.dbw100.id
  role_definition_name = "Owner"
  principal_id         = azuread_group.grp_adm_dbw.object_id
}
