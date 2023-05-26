# Networking

- Manages the Virtual Networking Infrastructure (VNI) and the access layer aspects
of the Physical Networking Infrastructure (PNI)

- Provides functionalities such as
    - subets, routers, security groups etc.

# Controller Node Configuration
## Database

Create the neutron database
```
sudo -u postgres createdb neutron
```

Create user `neutron`

```
sudo -u postgres createuser neutron
```

Log into the db and update password for neutron
```
sudo -u postgres psql neutron

# psql console
neutron=# \password neutron
```

Grant all access of the `neutron` db to the user `neutron`

```
neutron=# GRANT ALL PRIVILEGES ON DATABASE neutron TO neutron;
```

Add the following entry to `/var/lib/pgsql/data/pg_hba.conf` to allow access from neutron

```
host    neutron        neutron        controller              md5
```

Restart the db
```
sudo systemctl restart postgresql.service
```

## Create neutron user in Keystone
Export admin cred environment variable

```
. admin-openrc
```

Create `neutron` user
```
openstack user create --domain default --password-prompt neutron
```

Add admin role to the `neutron` user
```
openstack role add --project service --user neutron admin
```

Add neutron service entity
```
openstack service create --name neutron \
  --description "OpenStack Networking" network
```

Add Networking API endpoints
```
openstack endpoint create --region RegionOne \
  network public http://controller:9696

openstack endpoint create --region RegionOne \
  network internal http://controller:9696

openstack endpoint create --region RegionOne \
  network admin http://controller:9696
```

## Configure Self-service Network
Install packages
```
sudo yum install openstack-neutron openstack-neutron-ml2 \
  openstack-neutron-linuxbridge ebtables
```

Update the following fields in `/etc/neutron/neutron.conf`

Configure database
```
[database]
# ...
connection = postgresql+psycopg2://neutron:<db_password>@controller:5432/neutron
```


## References
[Install and configure controller node](https://docs.openstack.org/neutron/zed/install/controller-install-rdo.html)

[Networking Option 2: Self-service networks](https://docs.openstack.org/neutron/zed/install/controller-install-option2-rdo.html)
