resource "azurerm_hdinsight_kafka_cluster" "hdk001" {
  name                = "hdk-das-dev-westeu-001"
  resource_group_name = azurerm_resource_group.rsg001.name
  location            = azurerm_resource_group.rsg001.location
  cluster_version     = "4.0"
  tier                = "Standard"

  component_version {
    kafka = "2.1"
  }

  gateway {
    enabled  = true
    username = "acctestusrgw"
    password = "TerrAform123!"
  }

  storage_account {
    storage_container_id = azurerm_storage_container.stc001.id
    storage_account_key  = azurerm_storage_account.sta001.primary_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "Standard_D1_V2"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }

    worker_node {
      vm_size                  = "Standard_D1_V2"
      username                 = "acctestusrvm"
      password                 = "AccTestvdSC4daf986!"
      number_of_disks_per_node = 3
      target_instance_count    = 3
    }

    zookeeper_node {
      vm_size  = "Standard_D3_V2"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }
  }
}
