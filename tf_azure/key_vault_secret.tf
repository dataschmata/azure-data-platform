resource "time_sleep" "wait_creation" {
  depends_on      = [azurerm_role_assignment.role_kvt_sec]
  create_duration = "300s"
}

resource "random_password" "aad_users" {
  count       = length(local.aad_users)
  length      = 30
  upper       = true
  lower       = true
  number      = true
  special     = true
  min_lower   = 3
  min_upper   = 3
  min_numeric = 3
  min_special = 3
}

resource "azurerm_key_vault_secret" "kvt_sec_sp" {
  name         = "sec-${azuread_service_principal.sp_dbw.display_name}"
  value        = azuread_service_principal_password.sp_dbw_sec.value
  key_vault_id = azurerm_key_vault.kvt_main.id
  depends_on   = [time_sleep.wait_creation]
  # await role assignment
}

resource "azurerm_key_vault_secret" "kvt_sec_usr" {
  count        = length(local.aad_users)
  name         = join("",["sec-", regex("[[:alnum:]]", local.aad_users[count.index])])
  value        = random_password.aad_users[count.index].result
  key_vault_id = azurerm_key_vault.kvt_main.id
  depends_on   = [time_sleep.wait_creation]
  # await role assignment
}

# resource "azurerm_key_vault_secret" "kvt_sec_adm" {
#   name         = "sec-az-admin"
#   value        = random_password.password.result
#   key_vault_id = azurerm_key_vault.kvt_main.id
# }

# resource "azurerm_key_vault_secret" "kvt_sec_adm_dbw" {
#   name         = "sec-az-admin-dbw"
#   value        = random_password.password.result
#   key_vault_id = azurerm_key_vault.kvt_main.id
# }

