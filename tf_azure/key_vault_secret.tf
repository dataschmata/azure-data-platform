resource "azurerm_key_vault_secret" "kvt_sec_sp" {
  name         = "sec-sp"
  value        = azuread_service_principal_password.sp_dbw_sec.value
  key_vault_id = azurerm_key_vault.kvt_main.id
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

resource "random_password" "password" {
  for_each = toset(local.aad_users)

  keepers = {
    "aad_user" = "${each.key}"
  }

  length      = 30
  upper       = true
  lower       = true
  number      = true
  special     = true
  min_lower   = 2
  min_upper   = 2
  min_numeric = 2
  min_special = 2
}
