# OMHM_TERRA Azure Virtual Network Module
## Features
* Virtual Network: Each Virtual Network Consists of 5 subnets
    * Private Subnet
    * Public Subnet
    * Db Subnet
    * Workers Subnet
    * Extra Subnet

# Virtual Network
name - (Required) The name of the virtual network. Changing this forces a new resource to be created.

resource_group_name - (Required) The name of the resource group in which to create the virtual network.

address_space - (Required) The address space that is used the virtual network. You can supply more than one address space. Changing this forces a new resource to be created.

location - (Required) The location/region where the virtual network is created. Changing this forces a new resource to be created.

ddos_protection_plan - (Optional) A ddos_protection_plan block as documented below.

dns_servers - (Optional) List of IP addresses of DNS servers

subnet - (Optional) Can be specified multiple times to define multiple subnets. Each subnet block supports fields documented below.

NOTE Since subnet can be configured both inline and via the separate azurerm_subnet resource, we have to explicitly set it to empty slice ([]) to remove it.

tags - (Optional) A mapping of tags to assign to the resource.
A ddos_protection_plan block supports the following:

id - (Required) The Resource ID of DDoS Protection Plan.

enable - (Required) Enable/disable DDoS Protection Plan on Virtual Network.

The subnet block supports:

name - (Required) The name of the subnet.

address_prefix - (Required) The address prefix to use for the subnet.

security_group - (Optional) The Network Security Group to associate with the subnet. (Referenced by id, ie. azurerm_network_security_group.example.id)

»Attributes Reference
The following attributes are exported:

id - The virtual NetworkConfiguration ID.

name - The name of the virtual network.

resource_group_name - The name of the resource group in which to create the virtual network.

location - The location/region where the virtual network is created.

address_space - The address space that is used the virtual network.

guid - The GUID of the virtual network.

subnet- One or more subnet blocks as defined below.

The subnet block exports:

id - The ID of this subnet.


azurerm_public_ip_prefix
Jump to Section
Manages a Public IP Prefix.

»Example Usage
resource "azurerm_resource_group" "example" {
  name     = "resourceGroup1"
  location = "West Europe"
}

resource "azurerm_public_ip_prefix" "example" {
  name                = "acceptanceTestPublicIpPrefix1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  prefix_length = 31

  tags = {
    environment = "Production"
  }
}
»Argument Reference
The following arguments are supported:

name - (Required) Specifies the name of the Public IP Prefix resource . Changing this forces a new resource to be created.

resource_group_name - (Required) The name of the resource group in which to create the Public IP Prefix.

location - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

sku - (Optional) The SKU of the Public IP Prefix. Accepted values are Standard. Defaults to Standard. Changing this forces a new resource to be created.

Note: Public IP Prefix can only be created with Standard SKUs at this time.

prefix_length - (Optional) Specifies the number of bits of the prefix. The value can be set between 0 (4,294,967,296 addresses) and 31 (2 addresses). Defaults to 28(16 addresses). Changing this forces a new resource to be created.
Please Note: There may be Public IP address limits on the subscription . More information available here

tags - (Optional) A mapping of tags to assign to the resource.

zones - (Optional) A collection containing the availability zone to allocate the Public IP Prefix in.

Please Note: Availability Zones are only supported in several regions at this time.

»Attributes Reference
The following attributes are exported:

id - The Public IP Prefix ID.
ip_prefix - The IP address prefix value that was allocated.
»Timeouts
The timeouts block allows you to specify timeouts for certain actions:

create - (Defaults to 30 minutes) Used when creating the Public IP Prefix.
update - (Defaults to 30 minutes) Used when updating the Public IP Prefix.
read - (Defaults to 5 minutes) Used when retrieving the Public IP Prefix.
delete - (Defaults to 30 minutes) Used when deleting the Public IP Prefix.
»Import

azurerm_network_ddos_protection_plan
Jump to Section
Manages an AzureNetwork DDoS Protection Plan.

NOTE Azure only allows one DDoS Protection Plan per region.

»Example Usage
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_network_ddos_protection_plan" "example" {
  name                = "example-protection-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}
»Argument Reference
The following arguments are supported:

name - (Required) Specifies the name of the Network DDoS Protection Plan. Changing this forces a new resource to be created.

location - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

resource_group_name - (Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created.

tags - (Optional) A mapping of tags to assign to the resource.

»Attributes Reference
The following attributes are exported:

id - The ID of the DDoS Protection Plan

virtual_network_ids - A list of Virtual Network ID's associated with the DDoS Protection Plan.

»Timeouts
The timeouts block allows you to specify timeouts for certain actions:

create - (Defaults to 30 minutes) Used when creating the DDoS Protection Plan.
update - (Defaults to 30 minutes) Used when updating the DDoS Protection Plan.
read - (Defaults to 5 minutes) Used when retrieving the DDoS Protection Plan.
delete - (Defaults to 30 minutes) Used when deleting the DDoS Protection Plan.
»Import
Azure DDoS Protection Plan can be imported using the resource id, e.g.

terraform import azurerm_network_ddos_protection_plan.examp

azurerm_route
Jump to Section
Manages a Route within a Route Table.

NOTE on Route Tables and Routes: Terraform currently provides both a standalone Route resource, and allows for Routes to be defined in-line within the Route Table resource. At this time you cannot use a Route Table with in-line Routes in conjunction with any Route resources. Doing so will cause a conflict of Route configurations and will overwrite Routes.

»Example Usage
resource "azurerm_resource_group" "example" {
  name     = "acceptanceTestResourceGroup1"
  location = "West US"
}

resource "azurerm_route_table" "example" {
  name                = "acceptanceTestRouteTable1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_route" "example" {
  name                = "acceptanceTestRoute1"
  resource_group_name = azurerm_resource_group.example.name
  route_table_name    = azurerm_route_table.example.name
  address_prefix      = "10.1.0.0/16"
  next_hop_type       = "vnetlocal"
}
»Argument Reference
The following arguments are supported:

name - (Required) The name of the route. Changing this forces a new resource to be created.

resource_group_name - (Required) The name of the resource group in which to create the route. Changing this forces a new resource to be created.

route_table_name - (Required) The name of the route table within which create the route. Changing this forces a new resource to be created.

address_prefix - (Required) The destination CIDR to which the route applies, such as 10.1.0.0/16

next_hop_type - (Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None

next_hop_in_ip_address - (Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.

»Attributes Reference
The following attributes are exported:

id - The Route ID.
»Timeouts
The timeouts block allows you to specify timeouts for certain actions:

create - (Defaults to 30 minutes) Used when creating the Route.
update - (Defaults to 30 minutes) Used when updating the Route.
read - (Defaults to 5 minutes) Used when retrieving the Route.
delete - (Defaults to 30 minutes) Used when deleting the Route.
»Import
Routes can be imported using the resource id, e.g.


azurerm_route_table
Jump to Section
Manages a Route Table

NOTE on Route Tables and Routes: Terraform currently provides both a standalone Route resource, and allows for Routes to be defined in-line within the Route Table resource. At this time you cannot use a Route Table with in-line Routes in conjunction with any Route resources. Doing so will cause a conflict of Route configurations and will overwrite Routes.

»Example Usage
resource "azurerm_resource_group" "example" {
  name     = "acceptanceTestResourceGroup1"
  location = "West US"
}

resource "azurerm_route_table" "example" {
  name                          = "acceptanceTestSecurityGroup1"
  location                      = azurerm_resource_group.example.location
  resource_group_name           = azurerm_resource_group.example.name
  disable_bgp_route_propagation = false

  route {
    name           = "route1"
    address_prefix = "10.1.0.0/16"
    next_hop_type  = "vnetlocal"
  }

  tags = {
    environment = "Production"
  }
}
»Argument Reference
The following arguments are supported:

name - (Required) The name of the route table. Changing this forces a new resource to be created.

resource_group_name - (Required) The name of the resource group in which to create the route table. Changing this forces a new resource to be created.

location - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

route - (Optional) List of objects representing routes. Each object accepts the arguments documented below.

NOTE Since route can be configured both inline and via the separate azurerm_route resource, we have to explicitly set it to empty slice ([]) to remove it.

disable_bgp_route_propagation - (Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable.

tags - (Optional) A mapping of tags to assign to the resource.

Elements of route support:

name - (Required) The name of the route.

address_prefix - (Required) The destination CIDR to which the route applies, such as 10.1.0.0/16

next_hop_type - (Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.

next_hop_in_ip_address - (Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.

»Attributes Reference
The following attributes are exported:

id - The Route Table ID.
subnets - The collection of Subnets associated with this route table.
»Timeouts
The timeouts block allows you to specify timeouts for certain actions:

create - (Defaults to 30 minutes) Used when creating the Route Table.
update - (Defaults to 30 minutes) Used when updating the Route Table.
read - (Defaults to 5 minutes) Used when retrieving the Route Table.
delete - (Defaults to 30 minutes) Used when deleting the Route Table.
»Import
Route Tables can be imported using the resource id, e.g.

terraform import azurerm_route_table.example /subscription

zurerm_subnet_route_table_association
Jump to Section
Associates a Route Table with a Subnet within a Virtual Network.

»Example Usage
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_route_table" "example" {
  name                = "example-routetable"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  route {
    name                   = "example"
    address_prefix         = "10.100.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
  }
}

resource "azurerm_subnet_route_table_association" "example" {
  subnet_id      = azurerm_subnet.example.id
  route_table_id = azurerm_route_table.example.id
}
»Argument Reference
The following arguments are supported:

route_table_id - (Required) The ID of the Route Table which should be associated with the Subnet. Changing this forces a new resource to be created.

subnet_id - (Required) The ID of the Subnet. Changing this forces a new resource to be created.

»Attributes Reference
The following attributes are exported:

id - The ID of the Subnet.
»Timeouts
The timeouts block allows you to specify timeouts for certain actions:

create - (Defaults to 30 minutes) Used when creating the Subnet Route Table Association.
update - (Defaults to 30 minutes) Used when updating the Subnet Route Table Association.
read - (Defaults to 5 minutes) Used when retrieving the Subnet Route Table Association.
delete - (Defaults to 30 minutes) Used when deleting the Subnet Route Table Association.
»Import
Subnet Route Table Associations can be imported using the resource id of the Subnet, e.g.

terraform import azurerm_subnet_route_table_association.association1 /subscripti

azurerm_subnet_network_security_group_association
Jump to Section
Associates a Network Security Group with a Subnet within a Virtual Network.

»Example Usage
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}
»Argument Reference
The following arguments are supported:

network_security_group_id - (Required) The ID of the Network Security Group which should be associated with the Subnet. Changing this forces a new resource to be created.

subnet_id - (Required) The ID of the Subnet. Changing this forces a new resource to be created.

»Attributes Reference
The following attributes are exported:

id - The ID of the Subnet.
»Timeouts
The timeouts block allows you to specify timeouts for certain actions:

create - (Defaults to 30 minutes) Used when creating the Subnet Network Security Group Association.
update - (Defaults to 30 minutes) Used when updating the Subnet Network Security Group Association.
read - (Defaults to 5 minutes) Used when retrieving the Subnet Network Security Group Association.
delete - (Defaults to 30 minutes) Used when deleting the Subnet Network Security Group Association.
»Import
Subnet <-> Network Security Group Associations can be imported using the resource id of the Subnet, e.g.

terraform import azurerm_subnet_netwo

azurerm_route
Jump to Section
Manages a Route within a Route Table.

NOTE on Route Tables and Routes: Terraform currently provides both a standalone Route resource, and allows for Routes to be defined in-line within the Route Table resource. At this time you cannot use a Route Table with in-line Routes in conjunction with any Route resources. Doing so will cause a conflict of Route configurations and will overwrite Routes.

»Example Usage
resource "azurerm_resource_group" "example" {
  name     = "acceptanceTestResourceGroup1"
  location = "West US"
}

resource "azurerm_route_table" "example" {
  name                = "acceptanceTestRouteTable1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_route" "example" {
  name                = "acceptanceTestRoute1"
  resource_group_name = azurerm_resource_group.example.name
  route_table_name    = azurerm_route_table.example.name
  address_prefix      = "10.1.0.0/16"
  next_hop_type       = "vnetlocal"
}
»Argument Reference
The following arguments are supported:

name - (Required) The name of the route. Changing this forces a new resource to be created.

resource_group_name - (Required) The name of the resource group in which to create the route. Changing this forces a new resource to be created.

route_table_name - (Required) The name of the route table within which create the route. Changing this forces a new resource to be created.

address_prefix - (Required) The destination CIDR to which the route applies, such as 10.1.0.0/16

next_hop_type - (Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None

next_hop_in_ip_address - (Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.

»Attributes Reference
The following attributes are exported:

id - The Route ID.
»Timeouts
The timeouts block allows you to specify timeouts for certain actions:

create - (Defaults to 30 minutes) Used when creating the Route.
update - (Defaults to 30 minutes) Used when updating the Route.
read - (Defaults to 5 minutes) Used when retrieving the Route.
delete - (Defaults to 30 minutes) Used when deleting the Route.
»Import
Routes can be imported using the resource id, e.g.

terraform import azurerm_route.exampleRoute /subscrip

