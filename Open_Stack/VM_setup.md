# VM Setup

## Sample Setup Command

```
sudo virt-install --name open_stack_controller \
--description 'Controller node for openstack env' \
--ram 4096 \
--vcpus 1 \
--disk size=20 \
--os-type linux \
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

## Reading Materials
[How to create snapshot in Linux KVM VM/Domain](https://www.cyberciti.biz/faq/how-to-create-create-snapshot-in-linux-kvm-vmdomain/)