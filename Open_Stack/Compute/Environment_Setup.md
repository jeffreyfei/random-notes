# Environment Setup
Setting up the environment in the controller node including base packages and supporting services (e.g. DB, MQ, DHCP, chrony etc.)
## Setup DHCP
Sample DHCP setup
```xml
<network>
  <name>default</name>
  <uuid>e2e694ff-8334-4429-9b9c-d4edec3f201e</uuid>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:79:fd:30'/>
  <dns>
    <host ip='10.0.0.11'>
      <hostname>controller</hostname>
    </host>
    <host ip='10.0.0.31'>
      <hostname>compute1</hostname>
    </host>
  </dns>
  <ip address='10.0.0.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='10.0.0.2' end='10.0.0.254'/>
      <host mac='52:54:00:26:08:bd' ip='10.0.0.11'/>
      <host mac='52:54:00:bb:34:90' ip='10.0.0.31'/>
    </dhcp>
  </ip>
</network>
```

Edit DHCP config
```
sudo virsh net-edit default
```

Restart DHCP
```
sudo virsh net-destroy default && sudo virsh net-start default
```

## Network Config on VMs
Add the following to `/etc/sysconfig/network-scripts/ifcfg-INTERFACE_NAME`
```
DEVICE=INTERFACE_NAME
TYPE=Ethernet
ONBOOT="yes"
BOOTPROTO="none"
```

Add the following host names to `/etc/hosts` depending on your setup
```bash
# controller
10.0.0.11       controller

# compute1
10.0.0.31       compute1

# block1
10.0.0.41       block1

# object1
10.0.0.51       object1

# object2
10.0.0.52       object2
```

## Setup NTP
Install chrony
```
sudo yum install chrony
```

### Controller
Add to `/etc/chrony.conf`
```bash
# Allow NTP client access from other open stack nodes
allow 10.0.0.0/24
```

Add NTP service to firewall
```
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --reload
```

Start chrony service
```
systemctl enable chronyd.service
systemctl start chronyd.service
```

### Clients (e.g. compute, object storage etc.)
Comment out the default NTP server pool in `/etc/chrony.conf`. Normall starts with  `pool ...`

Add to `/etc/chrony.conf`
```bash
# Set controller as NTP server
server controller iburst
```

Start chrony service
```
systemctl enable chronyd.service
systemctl start chronyd.service
```

### Check NTP connectivity
```
chronyc sources
```

## Install OpenStack Packages
Installation release: zed
```
sudo yum install centos-release-openstack-zed
```

```
sudo yum upgrade
```

Restart if the upgrade includes a new kernel

Install OpenStack client
```
sudo yum install python3-openstackclient
```

Install openstack-selinux to automatically manage security policies
```
sudo yum install openstack-selinux
```

## Setup DB
Setting up DB which stores compute metadata
- The DB that will be used here is postgresql
- This can also be on a separate server. In this case we are setting it up on the controller node.

```bash
# Installl Postgresql
sudo yum install postgresql-server

# Install the python postgresql driver
sudo yum install gcc python3-devel postgresql-devel
sudo -H pip install pyscopg2
sudo -H pip install psycopg2-binary

# Initialize and start db
sudo postgresql-setup --initdb
sudo chmod +x /etc/rc.d/rc.local
sudo systemctl enable postgresql.service
sudo systemctl start postgresql.service
```
- pyscopg2 is the postgresql driver for python. This allows openstack services to interact with the DB

Set the following attribute in `/var/lib/pgsql/data/postgresql.conf`
```
listen_addresses = '*' 
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

## Setup Controller Based Services

Please configure the following controller based services in the following sequence

1. [Imaging](Imaging.md)