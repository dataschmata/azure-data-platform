##################################
# Users
##################################

admin_email     = ["admin@dataschmata.com"]
admin_dbw_email = ["dbw_admin@dataschmata.com"]
user_dbw_email  = ["dbw_user@dataschmata.com"]
admin_kvt_email = ["kvt_admin@dataschmata.com"]


##################################
# Virtual Network and SubNets
##################################

# pub_space and pvt_sapce for databricks needs to be the same size. 
vnt_space  = ["10.0.0.0/18"]
snt_prefix = ["10.0.0.0/20"]
pub_prefix = ["10.0.16.0/20"]
pvt_prefix = ["10.0.32.0/20"]


##################################
# Storage Account
##################################

sta_containers  = ["raw", "delta", "landing", "sandbox"]
sta_replication = "LRS"


##################################
# Databricks
##################################

dbw_sku         = "premium"
dbw_max_workers = 1


##################################
# Tags
##################################

environment = "dev"
workload    = "das"
scope       = "data_platform"
costcenter  = "99999999"

region = {
  "short"    = "weu1"
  "location" = "westeurope"
}

customer = {
  "name"  = "Customer Name"
  "email" = "customer.email@nomail.tst"
}

owner = {
  "name"  = "Owner Name"
  "email" = "owner.email@nomail.tst"
}

addtl_tags = {
  "test1" = "test one"
}
