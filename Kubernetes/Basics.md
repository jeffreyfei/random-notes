# Architecture and Terminologies

### Terminologies

**Nodes** - host that run Kubernetes applications
    - Runs on individual "servers"
    - Manages a collection of pods


**Pods** - units of deployment
    - Runs one or more containers
    - Has it's own IP address

**Containers** - units of packaging
    - Usually docker

**Replication Controller** - ensures availability and scalability

* Ensure that the containers are in the desired state in any given point of time

**Labels** - key-value pairs for identification

**Services** - collection of pods exposed as an endpoint
    - Facilitate communcation between pods by having a constant IP address
    - Identifies which pod belongs to it using labels

![](/assets/kubearch040730.png)

#### Pods

* Bring in multiple containers that needs to work together and stitch them together as one unit

* Storage resources

* Has unique network IP

* Governs how the containers should run

* Has multiple states

  * **Pending** - pod accepted by the Kubernetes system, but a container has not been created yet
  * **Running** - pod scheduled on a node and all the containers created with at least one container in the running state
  * **Succeeded** - all containers in the pod exited with a status of 0, the pod will not be restarted
  * **Failed** - all containers in the pod has exited with at least one container with a non-zero exit status
  * **CrashLoopBackOff** - pod fails to start, and Kubernetes tries over and over to restart the pod

### Controllers

#### ReplicaSet

* Ensures that a specified number of replicas of a pod are running at all times

#### Deployment

* Provides declarative updates for pods and replica sets
* A deloyment manages a replica set which in turn manages a pod
* A new replica set is created everytime a new deployment configuration is applied, which allows support for a roleback mechanism

* Use cases

  * **Pod management** - running a replica set runs a number of pods and they can be checked as a single unit
  * **Scaling** - scaling a replica set also scale out the pods
  * **Pause and Resume** - pause deployment to make changes, and resume deployment

#### DaemonSets

* Ensures that all nodes run a copy of a specified pod
* As nodes are added or removed from a cluster, a DaemonSet will add or remove the required pods

#### Job

* A supervisor process carrying out batch processes to completion
* e.g. cron job for nightly reports and data backups

#### Services

* Allows communcation between one set of deployments to another
* Has a unique IP address that never changes during it's lifetime
* Types of services
  * Internal - within a cluster
  * External - endpoint available through node IP
  * Load balancer - exposes application to the internet

### Labels

* Key/value pairs attached to objects like pods, services, and deployments
* For users of Kubernetes to identify attributes for objects

### Selectors

#### Equality-based Selectors

* Has _equa_l or not _equal_ operators
* Two labels or values of labels should be equal \(or not equal\)

#### Set-based Selectors

* **IN** - whether if the value is within a set of the defined values
* **NOTIN** - whether a value should not be inside a set of defined values
* **EXISTS** - whether the label exists or not

### Namespaces

* Allows you to have multiple virtual cluster backed by the same physical cluster
* Allows teams to access resources with accountibility
* Great way to divide cluster resources between users

### Kubelet

* The "Kubernetes node agent" that runs on each node

* Roles of Kubelet
  * Communicate with API servers to see if pods have been assigned to nodes
  * Executes pod containers via a container engine
  * Mounts and runs pod volumes and secrets
  * Executes health checks to identify pod/node status

* Runs the containers according to the Podspec \(a yaml file\)
  * Ensures that he containers described by the podspecs are running and healthy

### Kube-proxy

* Runs on all worker nodes
* Reflects services as defined on each node
* Can do simple network stream of round-robin forwarding across a set of backends
* Has three modes
  * Userspace
  * Iptables
  * Ipvs



