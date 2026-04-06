# -------------------------------------------------------
# AKS Cluster
# -------------------------------------------------------
resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.project_name}-${var.environment}"
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.aks_tier

  private_cluster_enabled = true

  # -------------------------------------------------------
  # System Node Pool
  # -------------------------------------------------------
  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = var.system_node_vm_size
    vnet_subnet_id      = var.aks_subnet_id
    zones               = ["1", "2", "3"]
    os_disk_size_gb     = 128

    only_critical_addons_enabled = true

    upgrade_settings {
      max_surge = "10%"
    }
  }

  # -------------------------------------------------------
  # Identity
  # -------------------------------------------------------
  identity {
    type = "SystemAssigned"
  }

  # -------------------------------------------------------
  # Network Profile
  # -------------------------------------------------------
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  # -------------------------------------------------------
  # Auto Upgrade
  # -------------------------------------------------------
  automatic_channel_upgrade = "patch"

  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}

# -------------------------------------------------------
# User Node Pool
# -------------------------------------------------------
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = var.user_node_vm_size
  vnet_subnet_id        = var.aks_subnet_id
  zones                 = ["1", "2", "3"]
  os_disk_size_gb       = 128

  enable_auto_scaling = true
  min_count           = var.user_node_min_count
  max_count           = var.user_node_max_count

  upgrade_settings {
    max_surge = "10%"
  }

  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}

# -------------------------------------------------------
# ACR Pull Role Assignment
# -------------------------------------------------------
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.main.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}