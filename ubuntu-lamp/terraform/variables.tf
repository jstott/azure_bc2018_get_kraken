variable "org" {
  default = "BootCamp"
}

variable "location" {
  default = "eastus2"
}
variable "environment" {
  default = "SANDBOX"
}

variable "project" {
  default = "LAMP"
}

variable default_tags {
  description = "Default tag values to be applied to all resources"
  type        = "map"
  default     = {}
}

## Vnet

variable dns_servers {}
variable vnet_cidr {}

variable subnet_cidrs {
  type = "map"
}

## VM's
variable expose_pip {
  default = "true"
}

variable admin_username {
  default = "automation"
}

variable vm_size {
  default = "Standard_B1ms" # 1CPU/2GM $18.25 p/month
}

variable lamp_private_ip_address {
  default = []
}

variable "storage_account_tier" {
  description = "Defines the Tier of storage account to be created. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Defines the Replication Type to use for this storage account. Valid options include LRS, GRS etc."
  default     = "LRS"
}
