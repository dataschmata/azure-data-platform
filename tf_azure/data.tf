data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "azurerm_client_config" "cfg" {
}

# data "databricks_current_user" "me" {}
# data "databricks_spark_version" "latest" {}
# data "databricks_node_type" "smallest" {
#   local_disk = true
# }