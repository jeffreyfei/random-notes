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


## Installation
## DB Creation

Create the placement database
```
sudo -u postgres createdb placement
```

Create user `placement`

```
sudo -u postgres createuser placement
```

Log into the db and update password for placement
```
sudo -u postgres psql placement

# psql console
placement=# \password placement
```

Grant all access of the `placement` db to the user `placement`

```
placement=# GRANT ALL PRIVILEGES ON DATABASE placement TO placement;
```

Add the following entry to `/var/lib/pgsql/data/pg_hba.conf` to allow access from placement

```
host    placement        placement        controller              md5
```

Restart the db
```
sudo systemctl restart postgresql.service
```

## Configure Placement User and Endpoint
Export openstack admin credentials

```
. admin_openrc
```

Create `placement` user

```
openstack user create --domain default --password-prompt placement
```

Add `placement` user to `service` project with admin role

```
openstack role add --project service --user placement admin
```

Create the placement API entry in the `service` catalog

```
openstack service create --name placement \
  --description "Placement API" placement
```

Create the placement API service endpoints
```
openstack endpoint create --region RegionOne \
  placement public http://controller:8778

openstack endpoint create --region RegionOne \
  placement internal http://controller:8778

openstack endpoint create --region RegionOne \
  placement admin http://controller:8778
```

## Install and Configure Package
```
sudo yum install openstack-placement-api
```

Update the following fields in `/etc/placement/placement.conf`

Replace `PLACEMENT_PASS` with the `placement` user password in keystone


```
[placement_database]
# ...
connection = postgresql+psycopg2://placement:<db_password>@controller:5432/placement

[api]
# ...
auth_strategy = keystone

[keystone_authtoken]
# ...
auth_url = http://controller:5000/v3
memcached_servers = controller:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = placement
password = PLACEMENT_PASS
```

Populate the `placement` db

```
sudo -u placement placement-manage db sync
```

Restart httpd service

```
sudo systemctl restart httpd
```

## Reference
[Placement usage](https://docs.openstack.org/placement/yoga/user/index.html#)

[Modeling with Provider Trees](https://docs.openstack.org/placement/zed/user/provider-tree.html)
