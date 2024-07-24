#CREATE RESOURCE GROUP
resource "azurerm_resource_group" "resource_group" {
  name     = "example-resources"
  location = "West Europe"
}

#CREATE LOG ANALYTICS WORKSPACE
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "acctest-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

#enable workload identity, oidc
#CREATE AKS CLUSTER
#add managed prometheus and grafana

#Note: The node pool create here is the system assigned. To create the user assigner 
#you have to use the k8s node resource. See Lowell or PWC terraform doc
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "example-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"
  kubernetes_version = ""
  sku_tier = ""
  http_application_routing_enabled = true
  azure_policy_enabled = true
  oidc_issuer_enabled = true
  workload_identity_enabled = true
  automatic_channel_upgrade = "node-image"
  node_os_channel_upgrade = "NodeImage"
  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    enable_auto_scaling = ""
    enable_host_encryption = true
    min_count = enable_auto_scaling == true ? var.min_count : null
    max_count = enable_auto_scaling == true ? var.max_count : null
  }
  #Load Balancer provides outbound connectivity to cluster nodes
  network_profile {
    load_balancer_sku = "standard"
    network_plugin = "azure"
    network_policy = ""
    outbound_type = "loadbalancer"
    load_balancer_profile {
      managed_outbound_ip_count = 1
    }
  }

  workload_autoscaler_profile {
    keda_enabled = ""
  }

  maintenance_window {
    allowed {
      day = "Friday"
      hours = 5
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }

  lifecycle {
    ignore_changes = [ node_count ]
  }
}

#CREATE AZURE MONITOR
resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "example"
  target_resource_id = azurerm_kubernetes_cluster.aks_cluster.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

#   enabled_log {
#     category = "AuditEvent"

#     retention_policy {
#       enabled = false
#     }
#   }

  enabled_log {
    category = "kube-apiserver"
  }

  enabled_log {
    category = "kube-audit"
  }

  enabled_log {
    category = "kube-audit-admin"
  }

  enabled_log {
    category = "kube-scheduler"
  }

  enabled_log {
    category = "cluster-autoscaler"
  }

  metric {
    category = "AllMetrics"
  }
}
