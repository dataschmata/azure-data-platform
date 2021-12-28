
variable "account_replication_type" {
  description = "type of replication of storage account"
  type        = map
  default     = {
          "dev" : "LRS"
          "test" : "LRS"
          "prod" : "ZRS"
  }
}

variable "clt_sec" {
  description = "azure subscription to be used"
  type        = map
  default     = {
          "dev" : "33zp.Ir48.x_-SI6TTeXeuA-G_Klq2mxZx"
          "test" : ".5Nljo_Af43E9nnRDh05K.F_VUsc-6niw4"
          "prod" : "7H.o_~E_t--UzXM6arfEQzb075X-_8W2w7"
  }
}

