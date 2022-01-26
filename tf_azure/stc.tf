# used due to issue https://github.com/hashicorp/terraform-provider-azurerm/issues/2977

resource "azurerm_resource_group_template_deployment" "sct100" {
  for_each            = toset(var.sta_containers)
  depends_on          = [azurerm_storage_account.sta100]
  name                = "ARM_Template_Container-${each.key}"
  resource_group_name = azurerm_resource_group.rsg_main.name
  deployment_mode     = "Incremental"
  template_content    = file("${path.module}/container.json")
  tags                = local.tags
  
  parameters_content = jsonencode({
    "storage_account_name" = { value = azurerm_storage_account.sta100.name },
    "container_name"       = { value = each.key }
  })
}

resource "azurerm_storage_data_lake_gen2_path" "adls_dict" {
  for_each           = toset(["bronze", "silver", "gold"])
  depends_on         = [azurerm_resource_group_template_deployment.sct100]
  path               = each.key
  filesystem_name    = "delta"
  storage_account_id = azurerm_storage_account.sta100.id
  resource           = "directory"
}