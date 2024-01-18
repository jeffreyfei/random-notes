# Pods

- Atomic unit of scheduling
- Kubelet runs in each pod that handles the communication between the pod and the controller
- One pod gets assigned to one node
- Each pod has its own unique IP address
    - Can be used to communicate with each other
- Containers within nodes communicate using localhost
- Usually deployed with Replication Controller
- Containers within a pod shares the same IP and uses the loopback network interface (localhost)
- Pod never span nodes

### Commands
Forwards an internal port of a pod to a port on the host
```
kubectl port-forward [name-of-pod] [external-port]:[internal-port]
```

Gives detailed information as well as an event log for the pod
```
kubectl describe pod [pod-name]
```

Access the shell from within the container
```
kubectl exec [pod-name] -it sh
```

### Probes
- **Readiness Probe** - When should a container start receiving traffic?
- **Liveness Probe** - When should a container restart?

Used to monitor health of the pod

Sample liveness probe:
```
spec:
    containers:
    - name: my-nginx
      image: ngix:alpine
      livenessProbe:
        httpGet:
            path: /index.html
            port: 80
        initialDelaySeconds:15
        timeoutSeconds: 2
        periodSeconds: 5
        failureThreshold: 1
```

Liveness probe will replace the container if it fails the liveness check
