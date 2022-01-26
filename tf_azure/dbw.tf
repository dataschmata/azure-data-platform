resource "azurerm_databricks_workspace" "dbw100" {
  name                        = "dbw-${local.name_conv}-100"
  resource_group_name         = azurerm_resource_group.rsg_main.name
  location                    = var.region["location"]
  managed_resource_group_name = local.rsg_dbw
  sku                         = "standard"
  tags                        = local.tags
  custom_parameters {
    no_public_ip             = true
    virtual_network_id       = azurerm_virtual_network.vnt_main.id
    public_subnet_name       = azurerm_subnet.snt_pub.name
    private_subnet_name      = azurerm_subnet.snt_pvt.name
    storage_account_name     = azurerm_storage_account.sta110.name
    storage_account_sku_name = "Standard_LRS"

    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.nga_pvt.id
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.nga_pub.id
  }

  depends_on = [
    azurerm_subnet_network_security_group_association.nga_pvt,
    azurerm_subnet_network_security_group_association.nga_pub,
  ]
}
