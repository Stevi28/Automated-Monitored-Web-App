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

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "aks_tier" {
  description = "AKS pricing tier"
  type        = string
}

variable "aks_subnet_id" {
  description = "ID of the AKS subnet"
  type        = string
}

variable "acr_id" {
  description = "ID of the ACR"
  type        = string
}

variable "system_node_count" {
  description = "Number of nodes in system node pool"
  type        = number
}

variable "system_node_vm_size" {
  description = "VM size for system node pool"
  type        = string
}

variable "user_node_min_count" {
  description = "Minimum number of nodes in user node pool"
  type        = number
}

variable "user_node_max_count" {
  description = "Maximum number of nodes in user node pool"
  type        = number
}

variable "user_node_vm_size" {
  description = "VM size for user node pool"
  type        = string
}