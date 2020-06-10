### AZ Resource Group Configuration ###
resource_group_name="test"
location="westus"

### Virtual Network ###
subnet_public_tags={
    name = "public"
    terraform = "true"
    address_prefix= ""
    security_group=""
}
subnet_private_tags={
    name = "private"
    terraform = "true"
    address_prefix= ""
    security_group=""
}
vnet_address_space = ["10.0.0.0/16"]
vnet_dns_servers =["8.8.8.8"]
vnet_tags = {
    terraform = "true"
}
