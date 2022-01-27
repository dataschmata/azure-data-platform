resource "azurerm_role_assignment" "role100" {
  scope                = azurerm_resource_group.rsg_main.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.cfg.object_id
}

resource "azurerm_role_assignment" "role_adm" {
  scope                = azurerm_resource_group.rsg_main.id
  role_definition_name = "Owner"
  principal_id         = azuread_group.grp_adm[each.key]
}

resource "azurerm_role_assignment" "role_adm_dbw" {
  scope                = azurerm_databricks_workspace.dbw100.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.grp_adm_dbw[each.key]
}
