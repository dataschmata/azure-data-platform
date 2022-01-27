
resource "azuread_user" "usr_adm" {
  for_each            = toset(var.admin_email)
  display_name        = each.key
  owners              = [data.azuread_client_config.ad_current.object_id]
  password            = "This1sA8adPa$$w0rd1!"
  user_principal_name = each.key
}

resource "azuread_user" "usr_adm_dbw" {
  for_each            = toset(var.admin_dbw_email)
  display_name        = each.key
  owners              = [data.azuread_client_config.ad_current.object_id]
  password            = "This1sA8adPa$$w0rd1!"
  user_principal_name = each.key
}

resource "azuread_group" "grp_adm" {
  for_each         = azuread_user.usr_adm
  display_name     = "az-${local.workload}-admin"
  # owners           = [data.azuread_client_config.ad_current.object_id]
  security_enabled = true

  members = [
    each.value.object_id,
    /* more users */
  ]
}

resource "azuread_group" "grp_adm_dbw" {
  for_each         = azuread_user.usr_adm_dbw
  display_name     = "az-${local.workload}-admin_dbw"
  # owners           = [data.azuread_client_config.ad_current.object_id]
  security_enabled = true

  members = [
    each.value.object_id,
    /* more users */
  ]
}
