variable "workload" {
  type        = string
  description = "Name of the workload, used in all resurce names"
  default     = "das"
}

variable "environment" {
  type        = string
  description = "environment"
  default     = "dev"
}

variable "region" {
  description = "Region in which to create the resources, short is used in names and location for location"
  type        = map(string)
  default = {
    "short"    = "weu1"
    "location" = "westeurope"
  }
}

variable "vnt_space" {
  description = "the address space of the main vnet"
  type        = list
  default = ["10.0.0.0/16"]
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
  type        = map
  default     = { }
}