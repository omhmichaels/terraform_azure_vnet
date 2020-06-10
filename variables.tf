
### AZ Resource Group Configuration ###
variable "resource_group_name" {
  description = "Name of Azure Resource Group to Create/Manage: "
}

variable "location" {
  description = "Location of Azure Resource to Create/Manage: "
}

### Azure Virtual Network ###
variable "vnet_address_space" {
  description = "Address Space of the Virtual Network"
  default     = ["10.0.0.0/16"]
}

variable "vnet_dns_servers" {
  description = "Dns Servers to use Within the Vnet"
  default     = ["8.8.8.8"]
}

variable "vnet_tags" {
  description = "Tags for your Virtual Network"
}

### Subnets ###
variable "subnet_public_tags" {
  description = "Tags for the public subnet"
}
variable "subnet_private_tags" {
  description = "Tags for the private subnet"
}