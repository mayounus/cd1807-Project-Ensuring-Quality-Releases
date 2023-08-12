resource "azurerm_network_interface" "vm" {
  name                = "nic-vm${var.vm_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
}

#Existing Image resource group
data "azurerm_resource_group" "GoldImage" {
  name = "vmimages-rg"
}
#Image
data "azurerm_shared_image_version" "GoldImageVM" {
  name                = "1.0.0"
  image_name          = "LinuxVMTestImage2"
  gallery_name        = "Images"
  resource_group_name = data.azurerm_resource_group.GoldImage.name
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.vm_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.vm.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCMEf3fKLWBrxU0FFTMfT00a6765GsOaqO0gNwJ65ahhC/YqIqfUNekQaDkno1E56YDX4itYiW94z1pdeKflqYFivb1Xl4wNbiI0ABEebCqATfOCWnx8SFLtvA3UBbVkiVM68ObkP8Mm0oB1Wx8dQ8crBebpFq+jxzfTvQM4pYcAXiuRll2yGWoIQAHoPGFFp+9rr8E93xC/0sYkkn8xJ1Oed3Xb/f9aOEe5oz84VC4yNADe+i3g/Cv7zRZuIK7wYRM1gxMVcTW+5XnxzPRflSIXrLQVrtQK+ZkRJVtA7d9b+uMB62IjhkDGnA5HGWW9zl19RQ2/ZDwKwFQXI3ui5pv"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
