# -------------------------------------------------------
# Resource Group
# -------------------------------------------------------
module "resource_group" {
  source = "./modules/resource_group"

  project_name = var.project_name
  environment  = var.environment
  location     = var.location
}

# -------------------------------------------------------
# Networking
# -------------------------------------------------------
module "networking" {
  source = "./modules/networking"

  project_name                           = var.project_name
  environment                            = var.environment
  location                               = var.location
  resource_group_name                    = module.resource_group.net_name
  vnet_address_space                     = var.vnet_address_space
  aks_subnet_address_prefix              = var.aks_subnet_address_prefix
  private_endpoint_subnet_address_prefix = var.private_endpoint_subnet_address_prefix
}

# -------------------------------------------------------
# ACR
# -------------------------------------------------------
module "acr" {
  source = "./modules/acr"

  project_name               = var.project_name
  environment                = var.environment
  location                   = var.location
  resource_group_name        = module.resource_group.app_name
  sku                        = var.acr_sku
  private_endpoint_subnet_id = module.networking.private_endpoint_subnet_id
  vnet_id                    = module.networking.vnet_id

  depends_on = [
    module.networking
  ]
}

# -------------------------------------------------------
# AKS
# -------------------------------------------------------
module "aks" {
  source = "./modules/compute"

  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.app_name
  kubernetes_version  = var.kubernetes_version
  aks_tier            = var.aks_tier
  aks_subnet_id       = module.networking.aks_subnet_id
  acr_id              = module.acr.id

  system_node_count   = var.system_node_count
  system_node_vm_size = var.system_node_vm_size
  user_node_min_count = var.user_node_min_count
  user_node_max_count = var.user_node_max_count
  user_node_vm_size   = var.user_node_vm_size

  depends_on = [
    module.networking,
    module.acr
  ]
}

