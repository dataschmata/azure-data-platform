
variable "region" {
  description = "Region in which to create the resources, short is used in names and location for location"
  type        = map(string)
  # default = {
  #   "short"    = "weu1"
  #   "location" = "westeurope"
  # }
}

variable "sta_containers" {
  description = "the file systems to be created in the lake"
  type        = list(string)
  default     = ["raw", "delta", "landing", "sandbox"]
}

variable "vnt_space" {
  description = "the address space of the main vnet"
  type        = list(string)
  # default     = ["10.0.0.0/16"]
}

variable "snt_prefix" {
  description = "the address space of the main snt"
  type        = list(string)
  # default     = ["10.0.0.0/23"]
}

variable "pub_prefix" {
  description = "the address space of the public subnet for databricks"
  type        = list(string)
  # default     = ["10.0.2.0/20"]
}

variable "pvt_prefix" {
  description = "the address space of the privat subnet for databricks"
  type        = list(string)
  # default     = ["10.0.18.0/20"]
}

variable "sta_replication" {
  description = "Defines the type of replication to use for this storage account."
  type        = string
  default     = "LRS"
  }

#####################################
# info for tags
#####################################
variable "workload" {
  type        = string
  description = "Name of the workload, used in all resurce names"
  # default     = "das"
}

variable "environment" {
  type        = string
  description = "environment"
  default     = "dev"
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
  default     = "99999999"
}

variable "scope" {
  type        = string
  description = "scope"
  default     = "data_platform"
}

variable "tags" {
  description = "tags to be used for resources"
  type        = map(string)
  default     = {}
}
