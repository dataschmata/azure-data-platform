# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  General setup needed for all resources
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------

locals {
  tags = merge(
    var.addtl_tags,
    {
      env           = var.environment
      workload      = var.workload
      scope         = var.scope
      costcenter    = var.costcenter
      customer      = var.customer["name"]
      customeremail = var.customer["email"]
      owner         = var.owner["name"]
      owneremail    = var.owner["email"]
    },
  )

  client_id = data.azurerm_client_config.cfg.client_id

  #naming convention enforcement
  env_short = substr(var.environment, 0, 1)
  workload  = lower(var.workload)
  name_conv = "${local.workload}-${var.region["short"]}-${local.env_short}"
  name_cosh = "${var.region["short"]}-${local.env_short}"

  # resource group, vnet and subnet for majority of resources incl databricks
  rsg_main = "rsg-${local.name_conv}-100"
  vnt_main = "vnt-${local.name_conv}-100"
  snt_main = "snt-${local.name_conv}-100"
  nsg_main = "nsg-${local.name_conv}-100"

  # set up for databricks with resource group and storage account names and subnets with network security groups
  rsg_dbw = "rsg-${local.name_conv}-110"
  sta_dbw = replace("sta${local.name_conv}110", "-", "")
  snt_pub = "${local.snt_main}-pub"
  snt_pvt = "${local.snt_main}-pvt"
  nsg_pub = "${local.nsg_main}-pub"
  nsg_pvt = "${local.nsg_main}-pvt"

  # name for lock on resource to avoid changes in portal
  lck_main = "lck-${local.name_conv}-100"

  # KeyVault name 
  kvt_main = "kvt-${local.name_conv}-100"

}
