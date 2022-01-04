# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rsg-terraform-dev-westeu-001"
    storage_account_name = "statfsdevwesteu001"
    container_name       = "tfstate"
    key                  = "dasdev.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

