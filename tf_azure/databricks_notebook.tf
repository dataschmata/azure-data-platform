resource "databricks_directory" "my_custom_directory" {
  path             = "/config"
  delete_recursive = true
}

resource "databricks_notebook" "notebook" {
  content_base64 = base64encode(<<-EOT
    # created from ${abspath(path.module)}
    display(spark.range(10))
    EOT
  )
  path     = "/config"
  language = "PYTHON"
}