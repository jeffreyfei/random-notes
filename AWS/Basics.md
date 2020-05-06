# Basics

### Definitions

**VPC** - a virtual network dedicated to your AWS account

**Subnets** - a range of IP addresses in the VPC

#### Public Subnets

* Created to connect resources to the internet
  * e.g. webserver
* Requires setting up an internet gateway to be public

#### Private Subnets

* For private resources \(e.g. databases\)

#### Internet Gateway

* VPC component that allows communication between instances in VPC and the internet
* Provide a target the VPC route tables for internet-routable traffic
* Perform network address translation \(NAT\) for instances that have been assigned to public IPv4 addresses

* Can be created and attached to the VPC

#### Route Table

* Contains a set of routes to determine where network traffic is determined
* Each subnet must be associated with a route table
* Contain a route that directs internet-bound traffic to the internet gateway
  * Can be set to all destinations \(0.0.0.0/0, ::/0\)
  * Target is set to the corresponding subnet

#### Security Group

* Acts like a virtual firewall that controls in/outbound traffic
* Need to be set for the user to be able to access the server
* Has a type \(e.g. HTML, MySQL\)

#### Subnet Group

* A collection fo subnets \(typically private\) that you create in a VPC and that you then designated for your DB instances
* Each DB subnet group should have subnets in at least _two_ Availability Zones in a given region
* Required by Amazon RDS instances



