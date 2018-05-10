# Elastic Compute Cloud \(EC2\)

* provides resizable compute capacity in the cloud

### AMI

* Amazon Machine Image
* Provides the information required to launch an instance
  * Template for the root volume for the instance
  * Launch permissions that control which AWS accounts can use the AMI to launch instances
  * A block device mapping that specifies the volume to attach the instance when it is launched

**Protect against accidental termination** - since when an instance terminates it cannot be started again. This protects against accidental termination

### Elastic Block Store

* Network-attached virtual disk
* Used by the EC2 to store data

### Security Group

* A virtual firewall that controls the traffic for one or more instances
* Has a collection of rules
* Can be modified to control inbound and outbound traffic
  * e.g. you can only access the webserver if inbound for port 80 is open

### Reize EBS Volume

1. Stop instance
2. Change type
3. Reize
4. Click modify, confirm, close
5. Start instance



