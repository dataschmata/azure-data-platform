# # used due to issue https://github.com/hashicorp/terraform-provider-azurerm/issues/2977
# resource "random_id" "randomId" {
#   byte_length = 6
# }

# resource "azurerm_template_deployment" "sct001" {
#   count               = var.sta001.file_systems
#   depends_on          = [ azurerm_storage_account.sta001 ]
#   name                = "${azurerm_storage_account.sta001.name}-stc-${random_id.randomId.hex}"
#   resource_group_name = var.resource_group_name
#   deployment_mode     = "Incremental"
#   template_body       = file("${path.module}/container.json")
#   parameters          = {
#     storage_account_name = azurerm_storage_account.sta001.name
#     container_name       = var.sta001.file_systems[count.index].container_name
#   }
# }
