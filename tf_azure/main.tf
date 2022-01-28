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
      version = "0.4.6"
    }
  }

  backend "azurerm" {
    # rsg and sta expected in -backend-config for terraform init in pipeline
    container_name = "tfstate"
    key            = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "databricks" {
  # Configuration options
  host = azurerm_databricks_workspace.dbw100.workspace_url
}

provider "azuread" {
  # Configuration options
}