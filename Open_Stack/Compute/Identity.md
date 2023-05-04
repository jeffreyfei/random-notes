# Identity

Notes on the identity service (Keystone)

- Provides authentication and authorization services via RESTful API
- Maintains the service catalog to locate other services in the OpenStack deployment (service discovery?)

## Installation and Configuration
- This service by default runs on the controller node

### DB Setup and Initialization
Create the keystone database
```
sudo -u postgres createdb keystone
```

Create user `keystone`

```
sudo -u postgres createuser keystone
```

Log into the db and update password for keystone
```
sudo -u postgres psql keystone

# psql console
keystone=# \password keystone
```

Grant all access of the `keystone` db to the user `keystone`
```
keystone=# grant all priviledges on database keystone to keystone
```

Add the following entry to `/var/lib/pgsql/data/pg_hba.conf` to allow access from keystone
```
host    keystone        keystone        controller              md5
```
- md5 allows username / password authentication
Install packages
```
sudo yum install openstack-keystone httpd mod_wsgi
```

Update the following fields in `/etc/keystone/keystone.conf`
```
connection = postgres://keystone:<password>@controller:5432/keystone

provider = fernet
```

Populate the identity service database
```
sudo -u keystone keystone-manage db_sync
```
Initialize Fernet key repositories
- Replace ADMIN_PASS with password
```bash
sudo keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
sudo keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

# Bootstrap the Identity service
sudo keystone-manage bootstrap --bootstrap-password <ADMIN_PASS> \
  --bootstrap-admin-url http://controller:5000/v3/ \
  --bootstrap-internal-url http://controller:5000/v3/ \
  --bootstrap-public-url http://controller:5000/v3/ \
  --bootstrap-region-id RegionOne
```

Configure the Apache HTTP server
Add to `/etc/httpd/conf/httpd.conf`
```
ServerName controller
```

Create a symlink for `wsgi-keystone.conf`
```
ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/
```

## Finalize
Start the Apache HTTP service
```
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
```

Set the following environment variables when using OpenStack client
- Replace `ADMIN_PASS` with the password set previously
```
export OS_USERNAME=admin
export OS_PASSWORD=<ADMIN_PASS>
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
```

# References
[Identity service overview](https://docs.openstack.org/keystone/yoga/install/get-started-obs.html)

[Install and configure](https://docs.openstack.org/keystone/yoga/install/keystone-install-rdo.html)

[The pg_hba.conf File](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html)

[Creating User, database, and adding access on PostgreSQL](https://medium.com/coding-blocks/creating-user-database-and-adding-access-on-postgresql-8bfcd2f4a91e)