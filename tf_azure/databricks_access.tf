# secret for service principal
resource "databricks_secret_scope" "secret_scope" {
  name                     = azuread_service_principal.sp_dbw.display_name
  initial_manage_principal = "users"
  depends_on               = [azurerm_databricks_workspace.dbw100]
}

resource "databricks_secret" "secret" {
  key          = "terraform_secret"
  string_value = azuread_service_principal_password.sp_dbw_sec.value
  scope        = databricks_secret_scope.secret_scope.name
  depends_on   = [azurerm_databricks_workspace.dbw100]
}


# users and groups
resource "databricks_user" "admin_users" {
  for_each   = azuread_group.grp_adm_dbw
  user_name  = each.value.user_principal_name
  depends_on = [azurerm_databricks_workspace.dbw100]
}

resource "databricks_group_member" "admin_grp" {
  for_each   = databricks_user.admin_users
  group_id   = data.databricks_group.admins.id
  member_id  = each.value.id
  depends_on = [azurerm_databricks_workspace.dbw100]
}
