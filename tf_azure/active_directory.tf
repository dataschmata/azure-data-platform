
# admin/owners of the subscription
resource "azuread_user" "usr_adm" {
  for_each            = toset(var.admin_email)
  display_name        = each.key
  password            = "This1sA8adPa$$w0rd1!"
  user_principal_name = each.key
  # owners              = [data.azuread_client_config.ad_current.object_id]
}

resource "azuread_application" "app_dbw" {
  display_name     = "az-${local.workload}-databricks"
  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "sp_dbw" {
  application_id = azuread_application.app_dbw.application_id
  feature_tags {
    enterprise = true
  }
}

resource "azuread_service_principal_password" "sp_dbw_sec" {
  service_principal_id = azuread_service_principal.sp_dbw.object_id
  display_name         = "${local.workload}-terraform"
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
  for_each         = azuread_user.usr_adm
  display_name     = "az-${local.workload}-admin"
  security_enabled = true
  # owners           = [data.azuread_client_config.ad_current.object_id]

  members = [
    each.value.object_id,
    /* more users */
  ]
}

resource "azuread_group" "grp_adm_dbw" {
  display_name     = "az-${local.workload}-admin_dbw"
  security_enabled = true
  # owners           = [data.azuread_client_config.ad_current.object_id]
}

resource "azuread_group_member" "mem_adm_dbw" {
  for_each         = azuread_user.usr_adm_dbw
  group_object_id  = azuread_group.grp_adm_dbw.id
  member_object_id = each.value.object_id
}

resource "azuread_group_member" "mem_adm_dbwsp" {
  group_object_id  = azuread_group.grp_adm_dbw.id
  member_object_id = azuread_service_principal.sp_dbw.object_id
}
