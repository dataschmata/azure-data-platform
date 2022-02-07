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

resource "databricks_group_member" "adm_grp_mem" {
  for_each = toset(
    concat(
      data.azuread_users.usr_adm_dbw.user_principal_names,
      azuread_service_principal.sp_dbw.object_id,
    )
  )
  
  group_id  = databricks_group.admin_grp.id
  member_id = data.azuread_users.usr_adm_dbw.object_ids[count.index]
}

resource "databricks_group" "usr_grp" {
  display_name               = "${local.workload}-user"
}

resource "databricks_group_member" "usr_grp_mem" {
  for_each  = databricks_user.users
  group_id  = databricks_group.usr_grp.id
  member_id = each.value.id
}

resource "databricks_permissions" "cls_use_sgl" {
  cluster_id = databricks_cluster.db_cluster_sgl.cluster_id

  access_control {
    group_name       = databricks_group.usr_grp.display_name
    permission_level = "CAN_ATTACH_TO"
  }

  access_control {
    group_name       = databricks_group.admin_grp.display_name
    permission_level = "CAN_MANAGE"
  }
}

resource "databricks_permissions" "int_use_sgl" {
  instance_pool_id = databricks_instance_pool.dip_small.id

  access_control {
    group_name       = databricks_group.usr_grp.display_name
    permission_level = "CAN_ATTACH_TO"
  }

  access_control {
    group_name       = databricks_group.admin_grp.display_name
    permission_level = "CAN_MANAGE"
  }
}