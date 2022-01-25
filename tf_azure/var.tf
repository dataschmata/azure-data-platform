variable "workload" {
  type = string
  description = "Name of the workload, used in all resurce names"
  default     = "das"
}

variable "environment" {
  type = string
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

variable "resource_tags" {
  description = "Common tags to be used for all resources."
  type        = map
  default     = { }
}


