# Elastic Compute Cloud \(EC2\)

* provides resizable compute capacity in the cloud
* Can be accessed through the _Services_ menu

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

### Resize EBS Volume

1. Stop instance
2. Change type
3. Reize
4. Click modify, confirm, close
5. Start instance

## Auto Scaling

* Ensure that there is a correct number of EC2 instances running
  * Done with the _Auto Scaling Group_ \(a collection of EC2 instances\)
* Can specify **max/min** number of instances for each Auto Scaling Group
* Has a _Launch Configuration_ as a template for launching new EC2 instances

### Scaling Plans

* Tells Auto Scaling when and how to scale

1. **Maintain current instance levels** - periodic health checks; unhealthy instances are replaced
2. **Manual scaling** - define max/min/desired capacity for the Auto Scaling Group
3. **Schedule based** - predicable demands; scaling performed automatically as function of time and date
4. **Demand based** - define parameters \(e.g. CPU utilization rate\) to scale for unknown demands

### Steps

1. **Create launch configuration** \(found in Services &gt; EC2 &gt; Launch Configurations\)
   1. Click Create Auto Scaling Group
   2. Click Create launch configuration
   3. Create AMI
2. **Configure Auto Scaling Group** \(Configure Auto Scaling group details\)
   1. Configure Scaling Policies \(Keep initial size by default\)
   2. Review and confirm
3. **Verify your Auto Scaling group**
   1. Examine the details tab on the Auto Scaling Groups page
   2. Examine the Activity History tab \(current status of your instance\)
   3. Examine the Instance tab \(displays the lifecycle state\)



