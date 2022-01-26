tenant_id       = "88281ca8-e525-4a8d-b965-480a7ac2b970"
subscription_id = "9aaf76a1-3252-4daa-b293-faac15046878"

environment   = "dev"
workload      = "das"
scope         = "data_platform"
costcenter    = "99999999"
customeremail = "customer.email@nomail.tst"
owner         = "Owner Name"
owneremail    = "owner.email@nomail.tst"

# pub_space and pvt_sapce for databricks needs to be the same size. used for cluster vms
vnt_space = ["10.0.0.0/16"]
snt_space = ["10.0.0.0/23"]
pub_space = ["10.0.2.0/20"]
pvt_space = ["10.0.18.0/20"]

region = {
  "short"    = "weu1"
  "location" = "westeurope"
}
