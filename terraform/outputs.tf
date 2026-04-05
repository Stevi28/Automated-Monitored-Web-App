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