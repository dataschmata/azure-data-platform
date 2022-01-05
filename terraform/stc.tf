# used due to issue https://github.com/hashicorp/terraform-provider-azurerm/issues/2977

resource "azurerm_template_deployment" "sct001" {
  depends_on          = [ azurerm_storage_account.sta001 ]
  name                = "raw"
  resource_group_name = azurerm_resource_group.rsg001.name
  deployment_mode     = "Incremental"
  template_body       = file("${path.module}/container.json")
  
  parameters = {
    storage_account_name = azurerm_storage_account.sta001.name
    container_name       = "raw"
  }
}
