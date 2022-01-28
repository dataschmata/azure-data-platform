# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  General setup needed for all resources
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
locals {
  tags = merge(
    var.tags,
    {
      env           = var.environment
      workload      = var.workload
      scope         = var.scope
      costcenter    = var.costcenter
      customeremail = var.customer["email"]
      owner         = var.owner["name"]
      owneremail    = var.owner["email"]
    },
  )

  #naming convention enforcement
  env_short = substr(var.environment, 0, 1)
  workload  = lower(var.workload)
  name_conv = "${local.workload}-${var.region["short"]}-${local.env_short}"
  name_cosh = "${var.region["short"]}-${local.env_short}"

  # resource group, vnet and subnet for majority of resources imcl databricks
  rsg_main = "rsg-${local.name_conv}-100"
  vnt_main = "vnt-${local.name_conv}-100"
  snt_main = "snt-${local.name_conv}-100"
  nsg_main = "nsg-${local.name_conv}-100"

  rsg_dbw = "rsg-${local.name_conv}-110" # resource group for databricks
  snt_pub = "${local.snt_main}-pub"
  snt_pvt = "${local.snt_main}-pvt"
  nsg_pub = "${local.nsg_main}-pub"
  nsg_pvt = "${local.nsg_main}-pvt"

  lck_main = "lck-${local.name_conv}-100"

  # KeyVault
  kvt_main = "kvt-${local.name_conv}-100"

  backend_key = "${local.workload}_${local_env_short}.tfstate"
}
