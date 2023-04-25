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

## Reading Materials
[How to create snapshot in Linux KVM VM/Domain](https://www.cyberciti.biz/faq/how-to-create-create-snapshot-in-linux-kvm-vmdomain/)

[KVM libvirt assign static guest IP addresses using DHCP on the virtual machine](https://www.cyberciti.biz/faq/linux-kvm-libvirt-dnsmasq-dhcp-static-ip-address-configuration-for-guest-os/)