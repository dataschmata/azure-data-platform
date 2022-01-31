
# admin/owners of the subscription
resource "azuread_user" "usr_adm" {
  for_each            = toset(var.admin_email)
  display_name        = each.key
  password            = "This1sA8adPa$$w0rd1!"
  user_principal_name = each.key
  # owners              = [data.azuread_client_config.ad_current.object_id]
}

# admin/owners of the databricks namespace
resource "azuread_user" "usr_adm_dbw" {
  for_each            = toset(var.admin_dbw_email)
  display_name        = each.key
  password            = "This1sA8adPa$$w0rd1!"
  user_principal_name = each.key
  # owners              = [data.azuread_client_config.ad_current.object_id]
}

resource "azuread_group" "grp_adm" {
  display_name     = "az-${local.workload}-admin"
  security_enabled = true
  # owners           = [data.azuread_client_config.ad_current.object_id]

  members = [
    azuread_user.usr_adm[each.key],
    /* more users */
  ]
}

resource "azuread_group" "grp_adm_dbw" {
  display_name     = "az-${local.workload}-admin_dbw"
  security_enabled = true
  # owners           = [data.azuread_client_config.ad_current.object_id]

  members = [
    azuread_user.usr_adm_dbw[each.key],
    /* more users */
  ]
}

resource "azuread_group_member" "sp_adm_dbw" {
  group_object_id  = azuread_group.grp_adm_dbw.id
  member_object_id = local.object_id
}
