# Create all users in the AAD with random password
resource "azuread_user" "aad_usr" {
  count               = length(local.aad_users)
  display_name        = local.aad_users[count.index]
  password            = random_password.aad_users[count.index].result
  user_principal_name = local.aad_users[count.index]
}

# creation service principal for databricks specifically
resource "azuread_application" "app_dbw" {
  display_name     = "sp-${local.workload}-databricks"
  sign_in_audience = "AzureADMyOrg"
  feature_tags {
    hide = true
  }
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


##########################
# workload level
##########################

# admins
resource "azuread_group" "grp_adm" {
  display_name     = "az-${local.workload}-admin"
  security_enabled = true
}

resource "azuread_group_member" "mem_adm" {
  count            = length(var.admin_email)
  group_object_id  = azuread_group.grp_adm.id
  member_object_id = data.azuread_users.usr_adm.object_ids[count.index]
}

# # users
# resource "azuread_group" "grp_usr" {
#   display_name     = "az-${local.workload}-user"
#   security_enabled = true
# }

# resource "azuread_group_member" "mem_usr" {
#   count            = length(data.azuread_users.usr_usr.object_ids)
#   group_object_id  = azuread_group.grp_usr.id
#   member_object_id = data.azuread_users.usr_usr.object_ids[count.index]
# }

# key vault admin
resource "azuread_group" "grp_adm_kvt" {
  display_name     = "az-${local.workload}-admin-kvt"
  security_enabled = true
}

resource "azuread_group_member" "mem_adm_kvt" {
  count            = length(var.admin_kvt_email)
  group_object_id  = azuread_group.grp_adm_kvt.id
  member_object_id = data.azuread_users.usr_adm_kvt.object_ids[count.index]
}

resource "azuread_group_member" "mem_adm_kvtsp" {
  group_object_id  = azuread_group.grp_adm_kvt.id
  member_object_id = local.object_id
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
  count            = length(var.admin_dbw_email)
  group_object_id  = azuread_group.grp_adm_dbw.id
  member_object_id = data.azuread_users.usr_adm_dbw.object_ids[count.index]
}

resource "azuread_group_member" "mem_adm_dbwsp" {
  group_object_id  = azuread_group.grp_adm_dbw.id
  member_object_id = azuread_service_principal.sp_dbw.object_id
}

#users databricks
resource "azuread_group" "grp_usr_dbw" {
  display_name     = "az-${local.workload}-user-dbw"
  security_enabled = true
}

resource "azuread_group_member" "mem_usr_dbw" {
  count            = length(local.dbw_users)
  group_object_id  = azuread_group.grp_usr_dbw.id
  member_object_id = data.azuread_users.usr_usr_dbw.object_ids[count.index]
}
