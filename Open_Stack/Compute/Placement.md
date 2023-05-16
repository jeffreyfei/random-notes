# Placement

Notes on placement service for OpenStack

- Helps other services to register / delete resources (hardware resources for compute/workload)
- Mostly used by the Nova (compute service)
    - **nova-compute** - create resources provider record corresponding to the compute host on which the resource tracker runs
        - e.g. VCPU, STORAGE_DISK_SSD
    - **nova-scheduler** - selects a set of destionation host for the workload
        - An allocation will consume resource from the inventory set by the resource tracker

## Modeling
- Resource providers are ordered into a tree like structure
    - A parent provider can have multiple child providers, but a child provider can only have one parent provider
    - The **root provider** is the provider that's at the top of the tree hierarchy

## Sharing Resource Provider
- Resource provider can share resources via aggregate
    - Aggregate is like a group where resource providers within the same aggregate can pool their resources together to ssatisfy an allocation request

- The resources of child providers in a tree are automatically shared by the parent's provider's aggregate

- Aggregate can be filtered in allocation request via the `member_of` argument

## Reference
[Placement usage](https://docs.openstack.org/placement/yoga/user/index.html#)

[Modeling with Provider Trees](https://docs.openstack.org/placement/zed/user/provider-tree.html)
