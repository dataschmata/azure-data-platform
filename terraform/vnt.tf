#Create Virtual Network
resource "azurerm_virtual_network" "vnt001" {
  name                = "vnt-das-dev-westeu-001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rsg001.location
  resource_group_name = azurerm_resource_group.rsg001.name
}

resource "azurerm_network_security_group" "nsg001" {
  name                = "nsg-das-dev-westeu-001"
  location            = azurerm_resource_group.rsg001.location
  resource_group_name = azurerm_resource_group.rsg001.name
}

# rule for github actions runner
resource "azurerm_network_security_rule" "nsgsr001" {
  name                        = "nsgsr-das-dev-westeu-001"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "${chomp(data.http.myip.body)}"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rsg001.name
  network_security_group_name = azurerm_network_security_group.nsg001.name
}

# Create Subnet
resource "azurerm_subnet" "snt001" {
  name                 = "snt-das-dev-westeu-001"
  resource_group_name  = azurerm_resource_group.rsg001.name
  virtual_network_name = azurerm_virtual_network.vnt001.name
  address_prefixes     = ["10.0.1.0/24"]
}
