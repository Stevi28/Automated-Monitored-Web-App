variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku" {
  description = "SKU for Azure Container Registry"
  type        = string
  default     = "Premium"
}

variable "private_endpoint_subnet_id" {
  description = "ID of the subnet for private endpoint"
  type        = string
}

variable "vnet_id" {
  description = "ID of the Virtual Network for DNS zone link"
  type        = string
}