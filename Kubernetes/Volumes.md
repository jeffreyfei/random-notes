# Volumes

- A volume refernces a storage location
- Must have a unique name

### Types of Volumes
- **emptyDir** - empty directory to store transient data; Useful for sharing files between containers; Shares lifecycle with the Pod.
- **hostPath** - Pod mounts into the node's filesystem
- **nfs** - An NFS (Network File System) share mounted into the Pod
- **configMap/secret** - Special types of volumes that provides a Pod with access
to Kubernetes resources
- **persistentVolumeClaim** - Provides Pods with a more persistent storage option
that is abstracted from the details
- **cloud** - Cluster wide storage

### Storage Classes
- Storage class allows the dynamic provisioning of PVs with a storage provider  when a PVC makes a claim
