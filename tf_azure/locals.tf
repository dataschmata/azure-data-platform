# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  General setup needed for all resources
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
env_short = substr(local.environment, 0, 1)
workload  = lower(var.workload)
name_conv = "${local.workload}-${var.region["short"]}-${local.env_short}"
name_cosh = "${var.region["short"]}-${local.env_short}"

# resource group, vnet and subnet for majority of resources imcl databricks
rsg_main = "rsg-${local.name_conv}-100"
lck100   = "lck-${local.name_conv}-100"

rsg_dbw  = "rsg-${local.name_conv}-110" # resource group for databricks
vnt_main = "vnt-${local.name_conv}-100"
snt_main = "snt-${local.name_conv}-100"
snt_pub  = "pub"
snt_pvt  = "pvt"

nsg_main = "nsg-${local.name_conv}-100"
nsg_pub  = "nsg-${local.name_conv}-100-${local.snt_pub}"
nsg_pvt  = "nsg-${local.name_conv}-100-${local.snt_pvt}"

udr001 = "udr-${local.name_conv}-100"

# KeyVault
kvt100 = "kvt-${local.name_conv}-100"