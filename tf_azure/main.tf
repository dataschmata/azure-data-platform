# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.93.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.15.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.4.4"
    }
  }

  backend "azurerm" {
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "databricks" {
  # Configuration options
  azure_workspace_resource_id = azurerm_databricks_workspace.dbw100.id
  azure_client_id             = data.azurerm_client_config.cfg.client_id
  azure_client_secret         = var.openDoor
  azure_tenant_id             = data.azurerm_client_config.cfg.tenant_id
}

provider "azuread" {
  # Configuration options
}