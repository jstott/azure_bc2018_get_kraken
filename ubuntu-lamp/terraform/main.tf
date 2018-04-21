provider "azurerm" {
  version = "~> 1.3" # any non-beta version >= 1.3.0 and < 1.4.0, e.g. 1.3.X

  # If NOT using azurerm_client_config below - uncomment
  #   subscription_id = "REPLACE-WITH-YOUR-SUBSCRIPTION-ID"
  #   client_id       = "REPLACE-WITH-YOUR-CLIENT-ID"
  #   client_secret   = "REPLACE-WITH-YOUR-CLIENT-SECRET"
  #   tenant_id       = "REPLACE-WITH-YOUR-TENANT-ID"
}

locals {
  fqResourceGroup = "${
    format("%s-%s-%s", var.org, 
      var.environment, 
      var.project)}"
}

# This doesn't work with Microsoft accounts or accounts that have two-factor authentication enabled!
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${local.fqResourceGroup}"
  location = "${var.location}"

  tags {
    workspace = "${terraform.workspace}"
  }
}

resource "azurerm_virtual_network" "default" {
  name                = "${format("%s-Vnet", local.fqResourceGroup)}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = ["${var.vnet_cidr}"]
  tags                = "${merge(var.default_tags, map("Name", format("%s.%s", var.org, terraform.workspace)))}"
}

resource "azurerm_subnet" "build" {
  name                 = "Build"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.default.name}"
  address_prefix       = "${lookup(var.subnet_cidrs, "Build")}"
}

resource "azurerm_storage_account" "stor" {
  name                     = "${lower(format("%s%sstor",terraform.workspace, var.project))}" 
  location                 = "${var.location}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  account_tier             = "${var.storage_account_tier}"
  account_replication_type = "${var.storage_replication_type}"
}

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}
module "lamp" {
  source = "../../modules/linuxVMs"

  resource_group            = "${azurerm_resource_group.rg.name}"
  rg_prefix                 = "${format("%s-%s-Jenkins", var.environment, var.project)}"
  number_of_servers         = 1
  vm_name                   = "ots-lamp"
  admin_username            = "${var.admin_username}"
  hostname                  = "ots-lamp"
  dns_name                  = "ots-lamp"
  number_of_servers         = 2
  expose_pip                = "${var.expose_pip}"
  pip_domain_name_label     = "${format("ots-lamp-%s", var.environment)}"
  location                  = "${var.location}"
  virtual_network_subnet_id = "${azurerm_subnet.build.id}"
  private_ip_address        = "${var.lamp_private_ip_address}"
  vm_size                   = "${var.vm_size}"
  ssh_public_key            = "${file("~/.ssh/ots_rsa.pub")}"
  tags                      = "${var.default_tags}"
}
