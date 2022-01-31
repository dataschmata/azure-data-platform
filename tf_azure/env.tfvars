environment = "dev"
workload    = "das"
scope       = "data_platform"
costcenter  = "99999999"

sta_containers  = ["raw", "delta", "landing", "sandbox"]
sta_replication = "LRS"
dbw_sku         = "standard"
dbw_max_workers = 1

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

# pub_space and pvt_sapce for databricks needs to be the same size. 
# used for cluster vms
vnt_space  = ["10.0.0.0/18"]
snt_prefix = ["10.0.0.0/20"]
pub_prefix = ["10.0.16.0/20"]
pvt_prefix = ["10.0.32.0/20"]

admin_email     = ["admin@dataschmata.com"]
admin_dbw_email = ["dbw_admin@dataschmata.com"]

# Data Aggregation Platform setup
