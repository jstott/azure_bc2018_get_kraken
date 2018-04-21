output "resource_group" {
  value = "${azurerm_resource_group.rg.name}"
}

output "backend_storage_account" {
  value = "${azurerm_storage_account.store.name}"
}

output "backend_storage_container" {
  value = "${azurerm_storage_container.container.name}"
}
