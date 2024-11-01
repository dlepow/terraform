resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "random_string" "azurerm_data_factory" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "random_string" "azurerm_storage_account" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_storage_account" "example" {
  name                     = random_string.azurerm_storage_account.result
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
}

resource "azurerm_data_factory" "example" {
  name                = random_string.azurerm_data_factory.result
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  identity {
    type = "SystemAssigned"
  }
}
