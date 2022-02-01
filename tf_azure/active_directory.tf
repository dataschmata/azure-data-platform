
# admin/owners of the subscription
resource "azuread_user" "usr_adm" {
  for_each            = toset(var.admin_email)
  display_name        = each.key
  password            = "This1sA8adPa$$w0rd1!"
  user_principal_name = each.key
  # owners              = [data.azuread_client_config.ad_current.object_id]
}

resource "azuread_application" "app_dbw" {
  display_name            = "az-${local.workload}-databricks"
  sign_in_audience        = "AzureADMyOrg"

  feature_tags {
    enterprise = true
  }
}

resource "azuread_application_password" "app_dbw_sec" {
  application_object_id = azuread_application.app_dbw.object_id
  display_name          = "az-${local.workload}-databricks-terraform"
  end_date_relative     = "4400h"
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
  for_each         = azuread_user.usr_adm_dbw
  display_name     = "az-${local.workload}-admin_dbw"
  security_enabled = true
  # owners           = [data.azuread_client_config.ad_current.object_id]

  members = [
    each.value.object_id,
    /* more users */
  ]
}
