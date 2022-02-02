resource "azurerm_key_vault_secret" "kvt_sec_sp" {
  name         = "sec_${azuread_service_principal.sp_dbw.display_name}"
  value        = azuread_service_principal_password.sp_dbw_sec.value
  key_vault_id = azurerm_key_vault.kvt_main.id
}

resource "azurerm_key_vault_secret" "kvt_sec_adm" {
  for_each     = toset(var.admin_email)
  name         = "sec_${each.key}"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.kvt_main.id
}

resource "azurerm_key_vault_secret" "kvt_sec_adm_dbw" {
  for_each     = toset(var.admin_dbw_email)
  name         = "sec_${each.key}"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.kvt_main.id
}

resource "random_password" "password" {
#   keepers = {
#     ami_id = "${var.ami_id}"
#   }
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