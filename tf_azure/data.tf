data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "azurerm_client_config" "cfg" {}

data "azuread_client_config" "ad_current" {}

# data "databricks_group" "admins" {
#   display_name = "admins"
#   depends_on   = [azurerm_databricks_workspace.dbw100]
# }

data "databricks_node_type" "dbc_smallest" {
  local_disk = true
  depends_on = [azurerm_databricks_workspace.dbw100]
}

# data "databricks_spark_version" "dbc_latest_lts" {
#   long_term_support = true
#   depends_on        = [azurerm_databricks_workspace.dbw100]
# }
