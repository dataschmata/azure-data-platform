resource "azurerm_role_assignment" "role100" {
  scope                = azurerm_resource_group.rsg_main.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.cfg.object_id
}