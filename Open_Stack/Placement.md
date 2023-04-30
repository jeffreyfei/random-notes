# Placement

Notes on placement service for OpenStack

- Helps other services to register / delete resources (hardware resources for compute/workload)
- Mostly used by the Nova (compute service)
    - **nova-compute** - create resources provider record corresponding to the compute host on which the resource tracker runs
        - e.g. VCPU, STORAGE_DISK_SSD
    - **nova-scheduler** - selects a set of destionation host for the workload
        - An allocation will consume resource from the inventory set by the resource tracker

## Reference
[Placement usage](https://docs.openstack.org/placement/yoga/user/index.html#)