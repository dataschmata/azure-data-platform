#Create Virtual Network
resource "azurerm_virtual_network" "vnt_main" {
  name                = local.vnt_main
  address_space       = var.vnt_space
  location            = var.region["location"]
  resource_group_name = azurerm_resource_group.rsg_main.name
  tags                = local.tags
}

resource "azurerm_network_security_group" "nsg_main" {
  name                = local.nsg_main
  location            = var.region["location"]
  resource_group_name = azurerm_resource_group.rsg_main.name
  tags                = local.tags
}

# rule for github actions runner
resource "azurerm_network_security_rule" "nsr100" {
  name                        = "nsr-${local.name_conv}-100"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = chomp(data.http.myip.body)
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rsg_main.name
  network_security_group_name = azurerm_network_security_group.nsg_main.name
}
