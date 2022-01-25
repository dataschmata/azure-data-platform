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
  type        = map
  default     = {
    "short"       = "weu1"
    "location"    = "westeurope"
  }
}

variable "customer" {
  description = "The main customer (user) of the resource"
  type        = map
  default     = {
    "name"  = "Customer Name"
    "email" = "customer.name@email.tst"
  }
}

variable "owner" {
  description = "The owne of the deployed resources"
  type        = map
  default     = {
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
