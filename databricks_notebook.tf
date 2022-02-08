resource "databricks_directory" "my_custom_directory" {
  path             = "/config"
  delete_recursive = true
  depends_on       = [azurerm_databricks_workspace.dbw100]
  # depends_on as workspace comes from azurerm provider
}

resource "databricks_notebook" "notebook" {
  content_base64 = base64encode(<<-EOT
    # created from ${abspath(path.module)}
    display(spark.range(10))
    EOT
  )
  path     = "/config/main"
  language = "PYTHON"

  depends_on = [azurerm_databricks_workspace.dbw100]
  # depends_on as workspace comes from azurerm provider
}