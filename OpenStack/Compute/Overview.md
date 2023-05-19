# Overview
Note for the compute service for opens tack (Nova)

Minimally contains two nodes: controller & compute

## Controller
Runs the Identity Service, Imaging service, management portion of Compute, management portion of networking etc.

- Can optionally run portions of the block and object storage if that is part of the setup
- Can also optionally run the dashboard
- Contains a DB

## Compute
Utilizes KVM to provide computing resources
Provides firewalling to instance via security groups

## Block Storage
Provides the disks used in the Block Storage and Shared File system functionality for the instances

## Object Storage
Provides the disks to store accounts, containers, and objects

## References

[Compute Overview](https://docs.openstack.org/nova/yoga/install/overview.html)