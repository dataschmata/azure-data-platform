# Create Subnet
resource "azurerm_subnet" "snt001" {
  name                 = "snt-${var.workload}-${var.environment}-${var.region["short"]}-001"
  resource_group_name  = azurerm_resource_group.rsg001.name
  virtual_network_name = azurerm_virtual_network.vnt001.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.EventHub"]
}

resource "azurerm_subnet" "snt002" {
  name                 = "snt-${var.workload}dbwpvt-${var.environment}-${var.region["short"]}-001"
  resource_group_name  = azurerm_resource_group.rsg001.name
  virtual_network_name = azurerm_virtual_network.vnt001.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.EventHub"]
}

resource "azurerm_subnet" "snt003" {
  name                 = "snt-${var.workload}dbwpub-${var.environment}-${var.region["short"]}-001"
  resource_group_name  = azurerm_resource_group.rsg001.name
  virtual_network_name = azurerm_virtual_network.vnt001.name
  address_prefixes     = ["10.0.3.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.EventHub"]
}

resource "azurerm_subnet_network_security_group_association" "nsga001" {
  subnet_id                 = azurerm_subnet.snt001.id
  network_security_group_id = azurerm_network_security_group.nsg001.id
}
