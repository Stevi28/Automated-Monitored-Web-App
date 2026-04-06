output "id" {
  description = "ID of the ACR"
  value       = azurerm_container_registry.main.id
}

output "login_server" {
  description = "Login server for ACR"
  value       = azurerm_container_registry.main.login_server
}

output "name" {
  description = "Name of the ACR"
  value       = azurerm_container_registry.main.name
}