####################################
# User
####################################
variable "admin_email" {
  description = "email address list of admins of platform"
  type        = list(string)
}

variable "admin_dbw_email" {
  description = "email address list of admins of databricks"
  type        = list(string)
}

variable "openDoor" {
  description = "Opens the door for databricks provider"
  type        = string
}

variable "dbw_sku" {
  description = "Databricks workspace SKU"
  type        = string
  default     = "standard"
}

variable "dbw_max_workers" {
  description = "Databricks cluster max_workers autoscale"
  type        = number
  default     = 2
}

variable "region" {
  description = "Region in which to create the resources"
  type        = map(string)
  default = {
    "short"    = "weu1"
    "location" = "westeurope"
  }
}

variable "sta_containers" {
  description = "the file systems to be created in the lake"
  type        = list(string)
  default     = ["raw", "delta", "landing", "sandbox"]
}

variable "vnt_space" {
  description = "the address space of the main vnet"
  type        = list(string)
  default     = ["10.0.0.0/18"]
}

variable "snt_prefix" {
  description = "the address space of the main snt"
  type        = list(string)
  default     = ["10.0.0.0/20"]
}

variable "pub_prefix" {
  description = "address space of public subnet for databricks"
  type        = list(string)
  default     = ["10.0.16.0/20"]
}

variable "pvt_prefix" {
  description = "address space of privat subnet for databricks"
  type        = list(string)
  default     = ["10.0.32.0/20"]
}

variable "sta_replication" {
  description = "Defines type of replication for storage account."
  type        = string
  default     = "LRS"
}

#####################################
# info for tags
#####################################
variable "workload" {
  type        = string
  description = "Name of the workload, used in all resource names"
}

variable "environment" {
  type        = string
  description = "environment"
}

variable "customer" {
  description = "The main customer (user) of the resource"
  type        = map(string)
  default = {
    "name"  = "Customer Name"
    "email" = "customer.name@email.tst"
  }
}

variable "owner" {
  description = "The owne of the deployed resources"
  type        = map(string)
  default = {
    "name"  = "Owner Name"
    "email" = "owner.name@email.tst"
  }
}

variable "costcenter" {
  type        = string
  description = "costcenter"
}

variable "scope" {
  type        = string
  description = "scope"
}

variable "addtl_tags" {
  description = "additional tags to be used for resources"
  type        = map(string)
}


## Cloud variables
variable "cloud" {
  description = "resources defaults to Azure public"
  type        = map(string)
  default = {
    keyvaultDns                    = ".vault.azure.net"
    mysqlServerEndpoint            = ".mysql.database.azure.com"
    postgresqlServerEndpoint       = ".postgres.database.azure.com"
    sqlServerHostname              = ".database.windows.net"
    storageEndpoint                = "core.windows.net"
    storageSyncEndpoint            = "afs.azure.net"
    synapseAnalyticsEndpoint       = ".dev.azuresynapse.net"
    activeDirectory                = "https://login.microsoftonline.com"
    activeDirectoryGraphResourceId = "https://graph.windows.net/"
    activeDirectoryResourceId      = "https://management.core.windows.net/"
    appInsightsResourceId          = "https://api.applicationinsights.io"
    logAnalyticsResourceId         = "https://api.loganalytics.io"
    management                     = "https://management.core.windows.net/"
    microsoftGraphResourceId       = "https://graph.microsoft.com/"
    portal                         = "https://portal.azure.com"
    resourceManager                = "https://management.azure.com/"
  }
}