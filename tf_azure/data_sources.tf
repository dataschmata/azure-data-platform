# to get the ip of the github action runner
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

# current azure rm configurqtion
data "azurerm_client_config" "cfg" {}

# current azure ad configuration
data "azuread_client_config" "ad_current" {}

# databricks admin group details
data "databricks_group" "admins" {
  display_name = "admins"
  depends_on   = [azurerm_databricks_workspace.dbw100]
  # depends_on as workspace comes from azurerm provider
}

# databricks cluster node details for smallest
data "databricks_node_type" "dbc_smallest" {
  local_disk = true
  depends_on = [azurerm_databricks_workspace.dbw100]
  # depends_on as workspace comes from azurerm provider
}

# databricks spark version details for latest
data "databricks_spark_version" "dbc_latest_lts" {
  long_term_support = true
  depends_on        = [azurerm_databricks_workspace.dbw100]
  # depends_on as workspace comes from azurerm provider
}

# get the users for each group membership 
data "azuread_users" "usr_usr_dbw" {
  user_principal_names = local.dbw_users
  depends_on           = [azuread_user.aad_usr]
}

data "azuread_users" "usr_adm_dbw" {
  user_principal_names = var.admin_dbw_email
  depends_on           = [azuread_user.aad_usr]
}

data "azuread_users" "usr_adm_kvt" {
  user_principal_names = local.kvt_admin
  depends_on           = [azuread_user.aad_usr]
}

data "azuread_users" "usr_adm" {
  user_principal_names = var.admin_email
  depends_on           = [azuread_user.aad_usr]
}
