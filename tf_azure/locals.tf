locals {
  # resource group, vnet and subnet for majority of resources
  rsg_main = "rsg-${local.name_conv}-100"
  vnt_main = "vnt-${local.name_conv}-100"
  snt_main = "snt-${local.name_conv}-100"
  nsg_main = "nsg-${local.name_conv}-100"
  sta_main = replace("sta${local.name_conv}100", "-", "")

  # set up for databricks with resource group and storage account names
  # as well as subnets with network security groups
  rsg_dbw = "rsg-${local.name_conv}-110"
  sta_dbw = replace("sta${local.name_conv}110", "-", "")
  snt_pub = "${local.snt_main}-pub"
  snt_pvt = "${local.snt_main}-pvt"
  nsg_pub = "${local.nsg_main}-pub"
  nsg_pvt = "${local.nsg_main}-pvt"

  # lock changes in portal directly (not used yet)
  lck_main = "lck-${local.name_conv}-100"

  # KeyVault name 
  kvt_main = "kvt-${local.name_conv}-100"


  # -------------------------------------------------------------------
  # -------------------------------------------------------------------
  #  No change needed
  # -------------------------------------------------------------------
  # -------------------------------------------------------------------

  tenant_id = data.azurerm_client_config.cfg.tenant_id
  client_id = data.azurerm_client_config.cfg.client_id
  object_id = data.azurerm_client_config.cfg.object_id

  # concat list of all users to be created in AAD
  aad_users = concat(
    var.admin_email,
    var.admin_dbw_email,
    var.user_email,
    var.user_dbw_email,
  )

  # concat list of all users to be created in Databricks
  dbw_users = concat(
    var.admin_dbw_email,
    var.user_dbw_email,
  )

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

  # naming convention support
  env_short = substr(var.environment, 0, 1)
  workload  = lower(var.workload)
  name_conv = "${local.workload}-${var.region["short"]}-${local.env_short}"
  name_cosh = "${var.region["short"]}-${local.env_short}"

  # databricks 
  tf_secret_scope = azuread_service_principal.sp_dbw.display_name
  tf_secret       = "${local.tf_secret_scope}_secret"

  # -------------------------------------------------------------------
  # -------------------------------------------------------------------
}
