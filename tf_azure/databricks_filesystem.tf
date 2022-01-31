resource "databricks_secret_scope" "secret_scope" {
  name                     = "terraform"
  initial_manage_principal = "users"
}

resource "databricks_secret" "secret" {
  key          = "terraform_secret"
  string_value = var.openDoor
  scope        = databricks_secret_scope.secret_scope.name
}

resource "databricks_mount" "db_mount" {
  for_each   = toset(var.sta_containers)
  name       = each.key
  cluster_id = databricks_cluster.db_cluster_sgl.id

  uri = "abfss://${each.key}@${local.sta_dbw}.dfs.${var.cloud["storageEndpoint"]}"
  extra_configs = {
    "fs.azure.account.auth.type" : "OAuth",
    "fs.azure.account.oauth.provider.type" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
    "fs.azure.account.oauth2.client.id" : local.client_id,
    "fs.azure.account.oauth2.client.secret" : "{{secrets/terraform/terraform_secret}}",
    "fs.azure.account.oauth2.client.endpoint" : "${var.cloud["activeDirectory"]}/${local.tenant_id}/oauth2/token",
    "fs.azure.createRemoteFileSystemDuringInitialization" : "false",
  }
}
