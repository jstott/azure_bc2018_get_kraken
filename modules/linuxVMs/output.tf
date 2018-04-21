output "vm" {
  value = ["${azurerm_virtual_machine.vm.*.name}"]
}

output "private-ip" {
  value = ["${azurerm_network_interface.nic.*.private_ip_address}"]
}

output "availability_set_id" {
  description = "ID of the Availaiblity Set."
  value       = "${azurerm_availability_set.vmavset.id}"
}
