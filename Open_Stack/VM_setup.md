# VM Setup

## Sample Setup Commands
### Controller
```
sudo virt-install --name open_stack_controller \
--description 'Controller node for openstack env' \
--ram 4096 \
--vcpus 1 \
--disk size=20,path=/var/lib/libvirt/images/open_stack_controller.qcow2 \
--os-variant centos-stream9 \
--network bridge=virbr0 \
--graphics none \
--location /var/lib/libvirt/isos/CentOS-Stream-9-latest-x86_64-dvd1.iso \
--extra-args='console=ttyS0'
```

- Console configuration in **extra-args** is crucial for console access to work from host machine

### Compute
```
sudo virt-install --name open_stack_compute \
--description 'Compute node for openstack env' \
--ram 2048 \
--vcpus 1 \
--disk size=20,path=/var/lib/libvirt/images/open_stack_compute.qcow2 \
--os-variant centos-stream9 \
--network bridge=virbr0 \
--graphics none \
--location /var/lib/libvirt/isos/CentOS-Stream-9-latest-x86_64-dvd1.iso \
--extra-args='console=ttyS0'
```

## Sample Snapshot Creation
```
sudo virsh snapshot-create-as --domain open_stack_controller \
--name "init-setup" \
--description \
"Initial centos setup for open stack controller node" \
--disk-only
```

**disk-only** - omits VM state in snapshot creation

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


## Reading Materials
[How to create snapshot in Linux KVM VM/Domain](https://www.cyberciti.biz/faq/how-to-create-create-snapshot-in-linux-kvm-vmdomain/)

[KVM libvirt assign static guest IP addresses using DHCP on the virtual machine](https://www.cyberciti.biz/faq/linux-kvm-libvirt-dnsmasq-dhcp-static-ip-address-configuration-for-guest-os/)

[OpenStack Doc](https://docs.openstack.org/install-guide/environment.html)

[How to configure chrony as an NTP client or server in Linux](https://www.redhat.com/sysadmin/chrony-time-services-linux)