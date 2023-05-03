# Compute
Note for the compute service for opens tack (Nova)

Minimally contains two parts: controller & compute

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

## Setup DB
Setting up DB which stores compute metadata

- This can also be on a separate server. In this case we are setting it up on the controller node.

```
sudo yum install postgresql-server
sudo postgresql-setup --initdb
sudo systemctl enable postgresql.service
sudo systemctl start postgresql.service
```

Set the following attribute in `/var/lib/pgsql/data/postgresql.conf`
```
listen_addresses = '10.0.0.11' 
```

Change the password of the user postgres
```
sudo -u postgres psql template1
```

In the console, type `\password`


Create the following DBs
```
sudo -u postgres createdb nova
sudo -u postgres createdb nova_api
sudo -u postgres createdb nova_cell0
```

## Setup MQ
Install message queue

``` bash
sudo yum install rabbitmq-server
sudo systemctl enable rabbitmq-server.service
sudo systemctl start rabbitmq-server.service
# Create user for openstack and set password
sudo rabbitmqctl add_user openstack <RABBIT_PASS>
# Permit config, read, and write access to the openstack user
sudo rabbitmqctl set_permissions openstack ".*" ".*" ".*"
```

## Setup memcached

```
sudo yum install memcached python3-memcached
```
Update the `OPTIONS` field `/etc/sysconfig/memcached`
```
OPTIONS="-l 127.0.0.1,::1,controller"
```
Enable service
```
sudo systemctl enable memcached.service
sudo systemctl start memcached.service
```

## Install etcd
- Key-value store used for distributed key locking, storing configuration, keep track of service liveliness etc.
```
sudo yum install etcd
```

Edit ` /etc/etcd/etcd.conf` and update the following fields

```
#[Member]
ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
ETCD_LISTEN_PEER_URLS="http://10.0.0.11:2380"
ETCD_LISTEN_CLIENT_URLS="http://10.0.0.11:2379"
ETCD_NAME="controller"
#[Clustering]
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://10.0.0.11:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://10.0.0.11:2379"
ETCD_INITIAL_CLUSTER="controller=http://10.0.0.11:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster-01"
ETCD_INITIAL_CLUSTER_STATE="new"
```
Enable and start etcd
```
sudo systemctl enable etcd
sudo systemctl start etcd
```

## References

[Compute Overview](https://docs.openstack.org/nova/yoga/install/overview.html)