variable "resource_group" {
  description = "The name of the resource group in which to create the backend store."
}

variable "location" {
  description = "The location/region where the resource group should be located"
}

variable "backend_storage_account" {
  description = "The storage account name"
}

variable "storage_account_kind" {
  description = "Defines the Kind of account, either BlobStorage or Storage"
  default     = "BlobStorage"
}

variable "storage_account_tier" {
  description = "Defines the Tier of this storage account: Standard or Premium"
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication used for this storage account"
  default     = "LRS"
}

variable "backend_storage_container" {
  description = "The storage container name"
}

variable "tags" {
  description = "Default tag values to be applied to all resources"
  type        = "map"
  default     = {}
}
