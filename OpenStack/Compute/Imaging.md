# Imaging

Notes on the imaging service (Glance)

- By default, it uses the local filesystem for storage
- Supports other forms of storage service such as object storage (cinder)
    - Other options includes RADOS block device, vSphere

# Installation
## DB Creation

Create the glance database
```
sudo -u postgres createdb glance
```

Create user `glance`

```
sudo -u postgres createuser glance
```

Log into the db and update password for glance
```
sudo -u postgres psql glance

# psql console
glance=# \password glance
```

Grant all access of the `glance` db to the user `glance`
```
glance=# GRANT ALL PRIVILEGES ON DATABASE glance TO glance;
```

Add the following entry to `/var/lib/pgsql/data/pg_hba.conf` to allow access from glance
```
host    glance        glance        controller              md5
```

- md5 allows username / password authentication

Restart the DB once updating the DB configs `sudo systemctl restart postgresql.service`

## Create OpenStack user for glance

Log into the openstack-cli by running the env file `. admin-openrc`

Create the `glance` user
```
openstack user create --domain default --password-prompt glance
```

Add the `glance` user to the `service` project
```
openstack role add --project service --user glance admin
```

Create the `glance` service entity
```
openstack service create --name glance \
  --description "OpenStack Image" image
```

Create the Image service API
```
openstack endpoint create --region RegionOne \
  image public http://controller:9292

openstack endpoint create --region RegionOne \
  image internal http://controller:9292

openstack endpoint create --region RegionOne \
  image admin http://controller:9292
```

## Package Installation

Enable the crb repo.
Without this, you will run into issues with the `python3-pyxattr` package being unavailable
```
sudo yum config-manager --set-enabled crb
```

Install openstack-glance
```
sudo yum install openstack-glance
```

Edit the config file at `/etc/glance/glance-api.conf`
```
# DB Connection
connection = postgresql+psycopg2://glance:<db_password>@controller:5432/glance
```

Configure identity service access
```
[keystone_authtoken]
# ...
www_authenticate_uri  = http://controller:5000
auth_url = http://controller:5000
memcached_servers = controller:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = glance
password = GLANCE_PASS

[paste_deploy]
# ...
flavor = keystone
```

Configure oslo limits

Create service account of `service-oslo` under the domain `default` and give reader
access to system-scope resources

```
openstack role add --user MY_SERVICE --user-domain Default --system all reader
```

Configure the `[oslo_limit]` section in the config file and replace the username and password field with the one
you just created
```
[oslo_limit]
auth_url = http://controller:5000
auth_type = password
user_domain_id = default
username = MY_SERVICE
system_scope = all
password = MY_PASSWORD
endpoint_id = ENDPOINT_ID
region_name = RegionOne
```

## Populate Image service DB

```
sudo -u glance glance-manage db_sync
```

## Start Service
```
sudo systemctl enable openstack-glance-api.service
sudo systemctl start openstack-glance-api.service
```

# References

[Install and configure](https://docs.openstack.org/glance/zed/install/install.html)
