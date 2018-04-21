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
  name     = "${format("%s-%s", var.resource_group, terraform.workspace)}"
  location = "${var.location}"
}

provider "azurerm" {
  version = "~> 1.3" 

    subscription_id = "1234"
    client_id       = "6789"
    client_secret   = "SECRET"
    tenant_id       = "9876"
}