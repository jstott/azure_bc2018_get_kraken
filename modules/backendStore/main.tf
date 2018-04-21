provider "azurerm" {
  version = "~> 1.3" # any non-beta version >= 1.3.0 and < 1.4.0, e.g. 1.3.X

  # If NOT using azurerm_client_config below - uncomment
  #   subscription_id = "REPLACE-WITH-YOUR-SUBSCRIPTION-ID"
  #   client_id       = "REPLACE-WITH-YOUR-CLIENT-ID"
  #   client_secret   = "REPLACE-WITH-YOUR-CLIENT-SECRET"
  #   tenant_id       = "REPLACE-WITH-YOUR-TENANT-ID"
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

resource "azurerm_storage_account" "store" {
  name                     = "${var.backend_storage_account}"
  location                 = "${var.location}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  account_kind             = "${var.storage_account_kind}"
  account_tier             = "${var.storage_account_tier}"
  account_replication_type = "${var.account_replication_type}"
  enable_blob_encryption   = "true"
  tags                     = "${var.tags}"
}

resource "azurerm_storage_container" "container" {
  name                  = "${var.backend_storage_container}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  storage_account_name  = "${azurerm_storage_account.store.name}"
  container_access_type = "private"
}
