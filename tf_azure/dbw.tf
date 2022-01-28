resource "azurerm_databricks_workspace" "dbw100" {
  name                        = "dbw-${local.name_conv}-100"
  resource_group_name         = azurerm_resource_group.rsg_main.name
  location                    = var.region["location"]
  managed_resource_group_name = local.rsg_dbw
  sku                         = var.dbw_sku
  tags                        = local.tags
  custom_parameters {
    no_public_ip             = true
    virtual_network_id       = azurerm_virtual_network.vnt_main.id
    public_subnet_name       = azurerm_subnet.snt_pub.name
    private_subnet_name      = azurerm_subnet.snt_pvt.name
    storage_account_name     = local.sta_dbw
    storage_account_sku_name = "Standard_LRS"

    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.nga_pvt.id
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.nga_pub.id
  }
}

resource "databricks_secret_scope" "secret_scope" {
  name                     = "terraform"
  initial_manage_principal = "users"
}

resource "databricks_secret" "secret" {
  key          = "terraform_secret"
  string_value = var.openDoor
  scope        = databricks_secret_scope.secret_scope.name
}

resource "databricks_cluster" "db_cluster_std" {
  depends_on              = [databricks_secret.secret]
  node_type_id            = data.databricks_node_type.dbc_smallest.id
  spark_version           = data.databricks_spark_version.dbc_latest_lts.id
  cluster_name            = "Standard"
  autotermination_minutes = 10
  is_pinned               = true

  autoscale {
    min_workers = 1
    max_workers = 2
  }

  azure_attributes {
    availability       = "SPOT_WITH_FALLBACK_AZURE"
    first_on_demand    = 0
    spot_bid_max_price = -1
  }

  # spark_conf = {
  #   "spark.databricks.cluster.profile": "serverless",
  #   "spark.databricks.acl.dfAclsEnabled": "true",
  #   "spark.databricks.repl.allowedLanguages": "sql,python,r",
  # }
}

resource "databricks_azure_adls_gen2_mount" "db_mount" {
  for_each               = toset(var.sta_containers)
  container_name         = each.key
  storage_account_name   = local.sta_dbw
  mount_name             = each.key
  tenant_id              = data.azurerm_client_config.cfg.tenant_id
  client_id              = data.azurerm_client_config.cfg.client_id
  client_secret_scope    = databricks_secret_scope.secret_scope.name
  client_secret_key      = databricks_secret.secret.key
  cluster_id             = databricks_cluster.db_cluster_std.id
  initialize_file_system = true
}
