# Virtualization

To build a experimental open stack environment on a laptop, we need a virtualization solution to spin up the controller, storage, virtualizer etc.

The most promising solution right now is KVM.

# KVM Setup Notes
Instructions: https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/

# Other Notes
NUMA - Non-uniform memory access
- Referring to multi-processor systems whose memory is divided into multiple memory node
- Linux provides system calls and files that manages the memory policy of processes
- See reading materials section for additonal readings

## Reading materials
- [Level 1 vs 2 hypervisors](https://ubuntu.com/blog/kvm-hyphervisor)
- [KVM Beginner's gudie](https://phoenixnap.com/kb/what-is-hypervisor-type-1-2)
- [NUMA](https://man7.org/linux/man-pages/man7/numa.7.html)