terraform {
 backend "azurerm" {
 }
 required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 1.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.60.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = ">= 0.3.0"
    }
    http = {
      source = "hashicorp/http"
    }
    local = {
      source = "hashicorp/local"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      source = "hashicorp/random"
    }
    time = {
      source = "hashicorp/time"
    }
    mysql = {
      source = "winebarrel/mysql"
      version = "1.10.3"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id[local.environment]
  tenant_id       = var.tenant_id
}


provider "databricks" {
  azure_workspace_resource_id   = azurerm_databricks_workspace.dbr001.id
  azure_client_id               = data.azurerm_client_config.current.client_id
  azure_client_secret           = var.clt_sec[local.environment]
  azure_tenant_id               = data.azurerm_client_config.current.tenant_id
}
