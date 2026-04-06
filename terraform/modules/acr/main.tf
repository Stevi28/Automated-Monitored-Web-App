# -------------------------------------------------------
# Azure Container Registry
# -------------------------------------------------------
resource "azurerm_container_registry" "main" {
  name                = "acr${var.project_name}${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false

  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}

# -------------------------------------------------------
# Private DNS Zone για ACR
# -------------------------------------------------------
resource "azurerm_private_dns_zone" "acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name

  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}

# -------------------------------------------------------
# Link DNS Zone με VNet
# -------------------------------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "acr" {
  name                  = "dns-link-acr-${var.project_name}-${var.environment}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr.name
  virtual_network_id    = var.vnet_id

  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}

# -------------------------------------------------------
# Private Endpoint για ACR (με DNS Zone Group μέσα)
# -------------------------------------------------------
resource "azurerm_private_endpoint" "acr" {
  name                = "pe-acr-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-acr-${var.project_name}-${var.environment}"
    private_connection_resource_id = azurerm_container_registry.main.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dzg-acr-${var.project_name}-${var.environment}"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr.id]
  }

  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.acr]
}