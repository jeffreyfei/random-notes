# Services

- Single point of entry to access one or more pods
- Services are not ephemeral
- Relies on labels to associate a Service with a Pod
- Load balances between pods


### Types of Services
- **ClusterIP Service** - Service IP is exposed internally to the cluster and only
pods within the same cluster can access it
- **NodePort Service** - Exposes the Service on each Node's IP at a static port (randomly assigned by default)
- **LoadBalancer Service** - Exposes a Service externally
    - Behind the scenes a NodePort service is created on each node that's responsible to talk to the load balancer. The NodePort service can also talk to other Services on the node which are created as ClusterIP Services.
- **ExternalName Service** - Service that acts as an alias for an external service
    - Allows different Pods to talk to an abstract layer instead of directly to an external service so that if any changes happens to the external service (e.g. DNS) we can just change the configuration of the ExternalName Service instead of the configuration of every Pods
