variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
  default     = "cloudnative"
}

# -------------------------------------------------------
# Networking
# -------------------------------------------------------
variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "aks_subnet_address_prefix" {
  description = "Address prefix for AKS subnet"
  type        = list(string)
  default     = ["10.240.0.0/16"]
}

variable "private_endpoint_subnet_address_prefix" {
  description = "Address prefix for private endpoints subnet"
  type        = list(string)
  default     = ["10.241.0.0/24"]
}

# -------------------------------------------------------
# ACR
# -------------------------------------------------------
variable "acr_sku" {
  description = "SKU for Azure Container Registry"
  type        = string
  default     = "Premium" # Premium required for private endpoints
}

# -------------------------------------------------------
# AKS
# -------------------------------------------------------
variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.33"
}

variable "aks_tier" {
  description = "AKS pricing tier"
  type        = string
  default     = "Standard"
}

variable "system_node_count" {
  description = "Number of nodes in system node pool"
  type        = number
  default     = 2
}

variable "system_node_vm_size" {
  description = "VM size for system node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "user_node_min_count" {
  description = "Minimum number of nodes in user node pool"
  type        = number
  default     = 1
}

variable "user_node_max_count" {
  description = "Maximum number of nodes in user node pool"
  type        = number
  default     = 2
}

variable "user_node_vm_size" {
  description = "VM size for user node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

# -------------------------------------------------------
# Key Vault
# -------------------------------------------------------
variable "key_vault_sku" {
  description = "SKU for Key Vault"
  type        = string
  default     = "standard"
}


# -------------------------------------------------------
# Cost Management
# -------------------------------------------------------
variable "monthly_budget_amount" {
  description = "Monthly budget in EUR"
  type        = number
  default     = 500
}
