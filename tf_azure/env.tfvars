environment = "dev"
workload    = "das"
scope       = "data_platform"
costcenter  = "99999999"

sta_containers  = ["raw", "delta", "landing", "sandbox"]
sta_replication = "LRS"

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

# pub_space and pvt_sapce for databricks needs to be the same size. used for cluster vms
vnt_space  = ["10.0.0.0/18"]
snt_prefix = ["10.0.0.0/20"]
pub_prefix = ["10.0.16.0/20"]
pvt_prefix = ["10.0.32.0/20"]

admin_email     = ["dennis.rossberg@posteo.de","deross@posteo.eu"]
admin_dbw_email = ["rocksde@posteo.eu"]

# Data Aggregation Platform setup