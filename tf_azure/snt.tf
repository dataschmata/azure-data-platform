# Create Subnet
resource "azurerm_subnet" "snt_main" {
  name                 = local.snt_main
  resource_group_name  = azurerm_resource_group.rsg_main.name
  virtual_network_name = azurerm_virtual_network.vnt_main.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.EventHub"]
}

resource "azurerm_subnet" "sntpub" {
  name                 = local.snt_pub
  resource_group_name  = azurerm_resource_group.rsg_main.name
  virtual_network_name = azurerm_virtual_network.vnt_main.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.EventHub"]
}

resource "azurerm_subnet" "sntpvt" {
  name                 = local.snt_pub
  resource_group_name  = azurerm_resource_group.rsg_main.name
  virtual_network_name = azurerm_virtual_network.vnt_main.name
  address_prefixes     = ["10.0.3.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.EventHub"]
}

resource "azurerm_subnet_network_security_group_association" "nsga100" {
  subnet_id                 = azurerm_subnet.snt_main.id
  network_security_group_id = azurerm_network_security_group.nsg001.id
}
