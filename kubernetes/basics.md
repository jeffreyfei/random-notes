# Architecture

### Terminologies

**Nodes** - host that run Kubernetes applications

**Pods** - units of deployment

**Containers** - units of packaging

**Replication Controller** - ensures availability and scalability

* Ensure that the containers are in the desired state in any given point of time

**Labels** - key-value pairs for identification

**Services** - collection of pods exposed as an endpoint

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



