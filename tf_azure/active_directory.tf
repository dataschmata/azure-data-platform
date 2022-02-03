# Create all users in the AAD
resource "azuread_user" "aad_usr" {
  for_each            = toset(local.aad_users)
  display_name        = each.key
  password            = "This1sA8adPa$$w0rd1!"
  user_principal_name = each.key
}

##########################
# workload level
##########################

# admins
resource "azuread_group" "grp_adm" {
  display_name     = "az-${local.workload}-admin"
  security_enabled = true
}

resource "azuread_group_member" "mem_adm" {
  for_each         = data.azuread_users.usr_usr.user
  group_object_id  = azuread_group.grp_adm.id
  member_object_id = each.value.object_id
}

# users
resource "azuread_group" "grp_usr" {
  display_name     = "az-${local.workload}-user"
  security_enabled = true
}

resource "azuread_group_member" "mem_usr" {
  for_each         = data.azuread_users.usr_usr.user
  group_object_id  = azuread_group.grp_usr.id
  member_object_id = each.value.object_id
}


##########################
# databricks namespace
##########################

# admins
resource "azuread_group" "grp_adm_dbw" {
  display_name     = "az-${local.workload}-admin-dbw"
  security_enabled = true
}

resource "azuread_group_member" "mem_adm_dbw" {
  for_each         = data.azuread_users.usr_adm_dbw.user
  group_object_id  = azuread_group.grp_adm_dbw.id
  member_object_id = each.value.object_id
}

#users
resource "azuread_group" "grp_usr_dbw" {
  display_name     = "az-${local.workload}-user-dbw"
  security_enabled = true
}

resource "azuread_group_member" "mem_usr_dbw" {
  for_each         = data.azuread_users.usr_usr_dbw.user
  group_object_id  = azuread_group.grp_usr_dbw.id
  member_object_id = each.value.object_id
}

# service principal for databricks
resource "azuread_application" "app_dbw" {
  display_name     = "sp-${local.workload}-databricks"
  sign_in_audience = "AzureADMyOrg"
  feature_tags {
    hide = true
  }
}

resource "azuread_group_member" "mem_adm_dbwsp" {
  group_object_id  = azuread_group.grp_adm_dbw.id
  member_object_id = azuread_service_principal.sp_dbw.object_id
}

resource "azuread_service_principal" "sp_dbw" {
  application_id = azuread_application.app_dbw.application_id
  feature_tags {
    hide = true
  }
}

resource "azuread_service_principal_password" "sp_dbw_sec" {
  service_principal_id = azuread_service_principal.sp_dbw.object_id
  display_name         = "${local.workload}-terraform"
}
