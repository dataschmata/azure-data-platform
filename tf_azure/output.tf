output "dbw_url" {
  description = "The URL of the Databricks workspace"
  value       = azurerm_databricks_workspace.dbw100.workspace_url
}

# output "global_settings" {
#   value = local.global_settings
# }