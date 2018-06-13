# Elastic Load Balancer

* Automatically distributes incoming application traffic across multiple Amazon EC2 instances
* Detects unhealthy instances and automatically reroutes traffic

* Has integration with AutoScaling and CloudWatch
  * AutoScaling fires off CloudWatch alarms to tell the ELB to add more instances to the AutoScaling groups
* Simple algorithms
  * Stick Sessions
  * Round Robin
* Can detect unhealthy instance and remove them from scaling
* CloudWatch adds instances based on ELB metrics

### Creation

1. Find _Load Balancers_ in the navigation pane
2. _Create Load Balancer_
3. Configure the load balancer
4. Confirm and create
5. Wait until the instances are in the status of inService

6. The DNS name is able to be accessed by the internet



