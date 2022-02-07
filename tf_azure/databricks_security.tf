# secret scope for service principal
resource "databricks_secret_scope" "secret_scope" {
  name                     = local.tf_secret_scope
  initial_manage_principal = "users"
  depends_on               = [
    azurerm_databricks_workspace.dbw100
  ]
  # depends_on as workspace comes from azurerm provider
}

resource "databricks_secret" "secret" {
  key          = local.tf_secret
  string_value = azuread_service_principal_password.sp_dbw_sec.value
  scope        = databricks_secret_scope.secret_scope.name
}

# adding users to databricks workspace
resource "databricks_user" "users" {
  for_each = toset(
    concat(
      data.azuread_users.usr_adm_dbw.user_principal_names,
      data.azuread_users.usr_usr_dbw.user_principal_names,
      azuread_service_principal.sp_dbw.object_id,
    )
  )

  user_name  = each.key
  depends_on = [
    azurerm_databricks_workspace.dbw100
  ]
  # depends_on as workspace comes from azurerm provider
}

# adding admin to databricks admin group

resource "databricks_group" "admin_grp" {
  display_name               = "${local.workload}-admin"
  allow_cluster_create       = true
  allow_instance_pool_create = true
}

resource "databricks_group_member" "admin_grp" {
  for_each = toset(
    concat(
      data.azuread_users.usr_adm_dbw.user_principal_names,
      azuread_service_principal.sp_dbw.object_id,
    )
  )
  
  group_id  = databricks_group.admin_grp.id
  member_id = data.azuread_users.usr_adm_dbw.object_ids[count.index]
}