variable "resource_group" {
  description = "The name of the resource group in which to create the virtual network."
}

variable "rg_prefix" {
  description = "The shortened abbreviation to represent your resource group that will go on the front of some resources."
  default     = "ots"
}

variable "number_of_servers" {
  description = "The number of virtual machines that should be created"
  default     = "1"
}

variable "expose_pip" {
  description = "Include public IP on NIC"
  default     = "false"
}

variable "pip_domain_name_label" {
  description = "Public IP domain prefix"
  default     = ""
}

variable "private_ip_address" {
  description = "Private IP Address List"
  type        = "list"
  default     = []
}

variable "private_ip_address_allocation" {
  description = "Type of private IP: Static or Dynamic"
  default     = "Dynamic"
}

variable "hostname" {
  description = "VM name referenced also in storage-related names."
}

variable "vm_name" {
  description = "VM name"
}

variable "dns_name" {
  description = " Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "virtual_network_subnet_id" {
  description = "The id for the subnet"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
}

variable "image_publisher" {
  description = "name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "the name of the offer (az vm image list)"
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "image sku to apply (az vm image list)"
  default     = "17.10"
}

variable "image_version" {
  description = "version of the image to apply (az vm image list)"
  default     = "17.10.201801260"
}

variable "admin_username" {
  description = "administrator user name"
}

variable "ssh_public_key" {
  description = "The public SSH key used for server provisioning"
}

variable "default_tags" {
  description = "Default tag values to be applied to all resources"
  type        = "map"

  default = {
    environment = "default"
  }
}

variable "tags" {
  description = "Default tag values to be applied to all resources"
  type        = "map"
  default     = {}
}
