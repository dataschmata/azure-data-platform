resource "azurerm_role_assignment" "role100" {
  scope                = azurerm_storage_account.sta100.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.cfg.object_id
}

resource "azurerm_role_assignment" "role_dbw_adm" {
  for_each             = azuread_group.grp_adm_dbw
  scope                = azurerm_storage_account.sta100.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = each.value.object_id
}

resource "azurerm_role_assignment" "role_adm" {
  for_each             = azuread_group.grp_adm
  scope                = azurerm_resource_group.rsg_main.id
  role_definition_name = "Owner"
  principal_id         = each.value.object_id
}

resource "azurerm_role_assignment" "role_dbw" {
  scope                = azurerm_storage_account.rsg_main.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_application.app_dbw.object_id
}


#########################
# Databricks roles/users/groups
#########################

resource "azurerm_role_assignment" "role_adm_dbw" {
  for_each             = azuread_group.grp_adm_dbw
  scope                = azurerm_databricks_workspace.dbw100.id
  role_definition_name = "Owner"
  principal_id         = each.value.object_id
}

resource "databricks_user" "admin_users" {
  for_each   = azuread_group.grp_adm_dbw
  user_name  = each.key
  depends_on = [azurerm_databricks_workspace.dbw100]
}

resource "databricks_group_member" "admin_grp" {
  for_each   = databricks_user.admin_users
  group_id   = data.databricks_group.admins.id
  member_id  = each.value.id
  depends_on = [azurerm_databricks_workspace.dbw100]
}
