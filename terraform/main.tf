terraform {
 backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "tfstatedevops"
    container_name       = "terraformgithubexample"
    key                  = "terraformgithubexample.tfstate"
 }
}

provider "azurerm" {
 version = "~>2.0"
 features {}
}


