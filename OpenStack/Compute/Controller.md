# Controller

## DB Setup
Create the following DBs
```
sudo -u postgres createdb nova
sudo -u postgres createdb nova_api
sudo -u postgres createdb nova_cell0
```
This was previously mentioned in the [Overview](Overview.md) section.

Create db user `nova`
```
sudo -u postgres createuser nova
```

Grant all access of the newly created db to the user `nova`

```
GRANT ALL PRIVILEGES ON DATABASE nova TO nova;
GRANT ALL PRIVILEGES ON DATABASE nova_api TO nova;
GRANT ALL PRIVILEGES ON DATABASE nova_cell0 TO nova;
```

Add the following entry to `/var/lib/pgsql/data/pg_hba.conf` to allow access from keystone

```
host    nova            nova            controller              md5
host    nova_api        nova            controller              md5
host    nova_cell0      nova            controller              md5
```

Restart the DB once updating the DB configs `sudo systemctl restart postgresql.service`

Export openstack admin user credentials

```
. admin_openrc
```

Create the `nova` user in identity service

```
openstack user create --domain default --password-prompt nova
```

Add the `admin` role to the `nova` user

```
openstack role add --project service --user nova admin
```

Create the `nova` service entity

```
openstack service create --name nova \
  --description "OpenStack Compute" compute
```

Create the Compute API endpoints
```
openstack endpoint create --region RegionOne \
  compute public http://controller:8774/v2.1

openstack endpoint create --region RegionOne \
  compute internal http://controller:8774/v2.1

openstack endpoint create --region RegionOne \
  compute admin http://controller:8774/v2.1
```

## Install and Configure Packages
```
sudo yum install openstack-nova-api openstack-nova-conductor \
  openstack-nova-novncproxy openstack-nova-scheduler
```

Update the `/etc/nova/nova.conf` file

Enable the compute and metadata APIs

```
[DEFAULT]
# ...
enabled_apis = osapi_compute,metadata
```

Configure db access

```
[api_database]
connection = postgresql+psycopg2://nova:<db_password>@controller:5432/nova_api

[database]
connection = postgresql+psycopg2://nova:<db_password>@controller:5432/nova
```

Configure RabbitMQ access. Replace **RABBIT_PASS** with the MQ password that was
set in the [Overview](Overview.md) section

```
[DEFAULT]
# ...
transport_url = rabbit://openstack:<RABBIT_PASS>@controller:5672/
```

Configure identity service access. Replace **NOVA_PASS** with the `nova` user password
in the Identity service

```
[api]
# ...
auth_strategy = keystone

[keystone_authtoken]
# ...
www_authenticate_uri = http://controller:5000/
auth_url = http://controller:5000/
memcached_servers = controller:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = nova
password = NOVA_PASS
```

Set the `my_ip` field in the default section to the ip of the controller

```
[DEFAULT]
# ...
my_ip = 10.0.0.11
```

Configure the `neutron` section for the networking service. Replace the **NEUTRON_PASS**
field with the neutron openstack user password once that has been set up.

```
[neutron]

auth_url = http://controller:5000
auth_type = password
project_domain_name = default
user_domain_name = default
region_name = RegionOne
project_name = service
username = neutron
password = NEUTRON_PASS
```


Configure the VNC proxy to use the `$my_ip` field that we have set

```
[vnc]
enabled = true
# ...
server_listen = $my_ip
server_proxyclient_address = $my_ip
```

Configure the location of the Image service API

```
[glance]
# ...
api_servers = http://controller:9292
```

Configure the lock path in the `oslo_concurrency` section

```
[oslo_concurrency]
# ...
lock_path = /var/lib/nova/tmp
```

Configure access to the placement service. Replace **PLACEMENT_PASS** with the `placement`
user password in the Identity service

```
[placement]
# ...
region_name = RegionOne
project_domain_name = Default
project_name = service
auth_type = password
user_domain_name = Default
auth_url = http://controller:5000/v3
username = placement
password = PLACEMENT_PASS
```

## Initialize DBs
Populate  the `nova-api` db
```
sudo -u nova nova-manage api_db sync
```

Register the `cell0` db
```
sudo -u nova nova-manage cell_v2 map_cell0
```

Create the `cell1` cell

```
nova-manage cell_v2 create_cell --name=cell1 --verbose
```

Populate the `nova` db
```
sudo -u nova nova-manage db sync
```

Register if `cell0` and `cell1` are registered correctly

```
sudo -u nova nova-manage cell_v2 list_cells
```

## Additional Configs

Before starting the service. There are some additional configurations that needs to be made
which is not mentioend in the standard openstack doc.

By default, the standard configuration does not grant access for apache to execute
the `/usr/bin/placement-api` script.

To grant the appropriate access to the file, add the following configuration within 
the `<VirtualHost></VirtualHost>` block in the file
`/etc/httpd/conf.d/00-placement-api.conf`

```xml
  <Directory /usr/bin>
    Require all denied
    <Files "placement-api">
      <RequireAll>
        Require all granted
        Require not env blockAccess
      </RequireAll>
    </Files>
  </Directory>
```

Details here:
https://storyboard.openstack.org/#!/story/2006905

## Start Services
```
# systemctl enable \
    openstack-nova-api.service \
    openstack-nova-scheduler.service \
    openstack-nova-conductor.service \
    openstack-nova-novncproxy.service
# systemctl start \
    openstack-nova-api.service \
    openstack-nova-scheduler.service \
    openstack-nova-conductor.service \
    openstack-nova-novncproxy.service
```

## References
[Install and configure controller node](https://docs.openstack.org/nova/wallaby/install/controller-install-rdo.html)
