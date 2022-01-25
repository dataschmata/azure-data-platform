tenant_id         = "88281ca8-e525-4a8d-b965-480a7ac2b970"
subscription_id   = "9aaf76a1-3252-4daa-b293-faac15046878"

environment       = "dev"
workload          = "das"

region = {
    "short"       = "weu1"
    "location"    = "westeurope"
  }

tags = {
    costcenter    = "99999999"
    customeremail = "customer.email@nomail.tst"
    owner         = "Owner Name"
    owneremail    = "owner.email@nomail.tst"
    scope         = "data_platform"
    tier          = $workload
    environment   = $environment
    }