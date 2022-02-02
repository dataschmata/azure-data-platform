# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.94.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.16.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.4.7"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }

  backend "azurerm" {
    # expected in -backend-config for terraform init in pipeline
    container_name = "tfstate"
    key            = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "databricks" {
  # Configuration options
  host = azurerm_databricks_workspace.dbw100.workspace_url
}

provider "azuread" {
  # Configuration options
  tenant_id = local.tenant_id
}

provider "random" {
  # Configuration options
}