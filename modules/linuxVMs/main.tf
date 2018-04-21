resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}

# Create public IPs - if optioned
resource "azurerm_public_ip" "pip" {
  count = "${var.expose_pip ? var.number_of_servers : 0}"
  name                         = "${format("%s-pip-%01d", var.vm_name, count.index)}"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  public_ip_address_allocation = "dynamic"
  domain_name_label            = "${lower( format("%s-%01d",var.pip_domain_name_label, count.index) )}"
  count = "${var.expose_pip ? var.number_of_servers : 0}"
}

resource "azurerm_network_interface" "nic" {
  name                = "${format("%s-nic-%01d", var.vm_name, count.index)}" #"${format(var.vm_name}-nic${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  count               = "${var.number_of_servers}"

  ip_configuration {
    name                          = "ipconfig${count.index}"
    subnet_id                     = "${var.virtual_network_subnet_id}"
    private_ip_address_allocation = "${var.private_ip_address_allocation}"
    private_ip_address            = "${element(var.private_ip_address, count.index)}"

    # public_ip_address_id          = "${var.expose_pip ? element(azurerm_public_ip.pip.*.id, count.index) : 0}"
    public_ip_address_id = "${length(azurerm_public_ip.pip.*.id) > 0 ? element(concat(azurerm_public_ip.pip.*.id, list("")), count.index) : ""}"
  }
}

resource "azurerm_availability_set" "vmavset" {
  name                         = "${var.dns_name}-avset"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  platform_fault_domain_count  = "${var.number_of_servers}"
  platform_update_domain_count = "${var.number_of_servers}"
  managed                      = true
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${format("%s-vm-%01d", var.vm_name, count.index)}"             # 'Author-00-vm'
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  availability_set_id   = "${azurerm_availability_set.vmavset.id}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
  count                 = "${var.number_of_servers}"

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name          = "${format("%s-osdisk-%01d", var.vm_name, count.index)}"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.hostname}"
    admin_username = "${var.admin_username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${var.ssh_public_key}"
    }
  }

  tags = "${var.tags}"
}
