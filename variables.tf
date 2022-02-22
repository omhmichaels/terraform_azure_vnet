
### AZ Resource Group Configuration ###
variable "resource_group_name" {
  description = "Name of Azure Resource Group to Create/Manage: "
  default = "project2alpha"
}

variable "location" {
  description = "Location of Azure Resource to Create/Manage: "
  default = "westus2"
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
  default = {environment = "test"}
}

### Subnets ###
variable "subnet_public_tags" {
  description = "Tags for the public subnet"
  default = ["10.0.0.0/24"]
}
variable "subnet_private_tags" {
  description = "Tags for the private subnet"
  default = ["10.0.0.0/24"]
}