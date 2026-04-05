terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstate2026weu28"
    container_name       = "tfstate"
    key                  = "production.terraform.tfstate"
  }
}