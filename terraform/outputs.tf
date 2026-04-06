# -------------------------------------------------------
# Resource Groups
# -------------------------------------------------------
output "resource_group_net_name" {
  description = "Name of the network resource group"
  value       = module.resource_group.net_name
}

output "resource_group_data_name" {
  description = "Name of the data resource group"
  value       = module.resource_group.data_name
}

output "resource_group_app_name" {
  description = "Name of the app resource group"
  value       = module.resource_group.app_name
}

output "resource_group_location" {
  description = "Location of the resource groups"
  value       = module.resource_group.location
}

# -------------------------------------------------------
# Networking
# -------------------------------------------------------
output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.networking.vnet_id
}

output "aks_subnet_id" {
  description = "ID of the AKS subnet"
  value       = module.networking.aks_subnet_id
}

output "private_endpoint_subnet_id" {
  description = "ID of the private endpoint subnet"
  value       = module.networking.private_endpoint_subnet_id
}

# -------------------------------------------------------
# ACR
# -------------------------------------------------------
output "acr_login_server" {
  description = "Login server for ACR"
  value       = module.acr.login_server
}

output "acr_id" {
  description = "ID of the ACR"
  value       = module.acr.id
}

# -------------------------------------------------------
# AKS
# -------------------------------------------------------
output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "aks_kube_config" {
  description = "Kubernetes config"
  value       = module.aks.kube_config
  sensitive   = true
}