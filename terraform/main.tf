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
