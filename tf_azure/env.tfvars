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

# pub_space and pvt_sapce for databricks needs to be the same size. used for cluster vms
vnt_space  = ["10.0.0.0/18"]
snt_prefix = ["10.0.0.0/20"]
pub_prefix = ["10.0.16.0/20"]
pvt_prefix = ["10.0.32.0/20"]

# Data Aggregation Platform setup