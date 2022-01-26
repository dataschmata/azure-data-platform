# used due to issue https://github.com/hashicorp/terraform-provider-azurerm/issues/2977

resource "azurerm_resource_group_template_deployment" "sct100" {
  depends_on          = [azurerm_storage_account.sta100]
  name                = "ARM_Template_Container"
  resource_group_name = azurerm_resource_group.rsg_main.name
  deployment_mode     = "Incremental"
  template_content    = file("${path.module}/container.json")
  parameters_content  = jsonencode({
    "storage_account_name" = {
      value = azurerm_storage_account.sta100.name
    },
    "container_name" = {
      value = "raw"
    }
  })
}
