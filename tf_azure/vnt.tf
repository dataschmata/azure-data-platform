#Create Virtual Network
resource "azurerm_virtual_network" "vnt001" {
  name                = "vnt-${var.workload}-${var.environment}-${var.region["short"]}-001"
  address_space       = ["10.0.0.0/16"]
  location            = var.region["location"]
  resource_group_name = azurerm_resource_group.rsg001.name
}

resource "azurerm_network_security_group" "nsg001" {
  name                = "nsg-${var.workload}-${var.environment}-${var.region["short"]}-001"
  location            = var.region["location"]
  resource_group_name = azurerm_resource_group.rsg001.name
}

# rule for github actions runner
resource "azurerm_network_security_rule" "nsgsr001" {
  name                        = "nsgsr-${var.workload}-${var.environment}-${var.region["short"]}-001"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = chomp(data.http.myip.body)
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rsg001.name
  network_security_group_name = azurerm_network_security_group.nsg001.name
}
