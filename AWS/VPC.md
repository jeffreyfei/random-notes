# Virtual Private Cloud \(VPC\)

* Logically isolated section of AWS where you can launch AWS resources in a virtual network that you define
  * IP addresses
  * Subnets
  * Route tables
  * Network gateways

### Types of VPCs

**Single Public Subnet** - ideal for applications purely in the AWS cloud

**Public and Private Subnets** - can be internet facing; ideal to separate private resources from the public

**Public and Private Subnets and Hardware VPN** - with VPN connection to an existing data center; ideal if there is a legacy infrastructure in a data center

**Private Subnet Only and Hardware VPN Access** - totally secure from internet access; ideal for providing additional resources using AWS; generally used for developing and testing

### Elastic IP Address

* A public IPv4 address reachable from the internet
* A static IP address
* Can be associated with a resource on VPC

### Network ACL

* ACL \(access control list\)
* Acts as a firewall for controlling traffic in and out of subnets

### NAT Gateways

* Allows resources in a private subnet to connect to the internet
* An outbound-only connection \(must be initiated from within the private subnet\)



