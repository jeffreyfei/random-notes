# VM Setup

Covers VM Setup that includes base packages for a generic nodes

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
--description "Initial centos setup for open stack controller node" \
--disk-only
```

**disk-only** - omits VM state in snapshot creation


## Reading Materials
[How to create snapshot in Linux KVM VM/Domain](https://www.cyberciti.biz/faq/how-to-create-create-snapshot-in-linux-kvm-vmdomain/)

[KVM libvirt assign static guest IP addresses using DHCP on the virtual machine](https://www.cyberciti.biz/faq/linux-kvm-libvirt-dnsmasq-dhcp-static-ip-address-configuration-for-guest-os/)

[OpenStack Doc](https://docs.openstack.org/install-guide/environment.html)

[How to configure chrony as an NTP client or server in Linux](https://www.redhat.com/sysadmin/chrony-time-services-linux)
