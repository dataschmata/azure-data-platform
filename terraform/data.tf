data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "azurerm_client_config" "cfg001" {
}
