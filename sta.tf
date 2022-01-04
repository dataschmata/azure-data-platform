resource "azurerm_storage_account" "sta001" {
  name                     = "stadasdevwesteu001"
  resource_group_name      = azurerm_resource_group.rsg001.name
  location                 = azurerm_resource_group.rsg001.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "stc001" {
  name                  = "hdinsight"
  storage_account_name  = azurerm_storage_account.sta001.name
  container_access_type = "private"
}

