# Create main Subnet
resource "azurerm_subnet" "snt_main" {
  name                 = local.snt_main
  resource_group_name  = azurerm_resource_group.rsg_main.name
  virtual_network_name = azurerm_virtual_network.vnt_main.name
  address_prefixes     = var.snt_prefix

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsga100" {
  subnet_id                 = azurerm_subnet.snt_main.id
  network_security_group_id = azurerm_network_security_group.nsg_main.id
}

###########################################
# "Public" subnet for databricks needed for control plane
resource "azurerm_subnet" "snt_pub" {
  name                 = local.snt_pub
  resource_group_name  = azurerm_resource_group.rsg_main.name
  virtual_network_name = azurerm_virtual_network.vnt_main.name
  address_prefixes     = var.pub_prefix
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

# empty security group being filled by databricks workspace deployment + association with subnet
resource "azurerm_network_security_group" "nsg_pub" {
  name                = local.nsg_pub
  location            = var.region["location"]
  resource_group_name = azurerm_resource_group.rsg_main.name
  tags                = local.tags
}

resource "azurerm_subnet_network_security_group_association" "nga_pub" {
  subnet_id                 = azurerm_subnet.snt_pub.id
  network_security_group_id = azurerm_network_security_group.nsg_pub.id
}

###########################################
# "Privat" subnet for databricks needed for data plane
resource "azurerm_subnet" "snt_pvt" {
  name                 = local.snt_pvt
  resource_group_name  = azurerm_resource_group.rsg_main.name
  virtual_network_name = azurerm_virtual_network.vnt_main.name
  address_prefixes     = var.pvt_prefix
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

# empty security group being filled by databricks workspace deployment + association with subnet
resource "azurerm_network_security_group" "nsg_pvt" {
  name                = local.nsg_pvt
  location            = var.region["location"]
  resource_group_name = azurerm_resource_group.rsg_main.name
  tags                = local.tags
}

resource "azurerm_subnet_network_security_group_association" "nga_pvt" {
  subnet_id                 = azurerm_subnet.snt_pvt.id
  network_security_group_id = azurerm_network_security_group.nsg_pvt.id
}
