# Probes
### Documentation
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

### Types of Probes
- **ExecAction** - executes an action inside the container
- **TCPSockerAction** - TCP check against the cotnainer's IP address on a specified port
- **HTTPGetAction** - HTTP GET request against containers


- Probes can produce the following results
    - Success
    - Failure
    - Unknown

### Sample Definition
#### Readiness Probe
Performs healthchecks on a pod using the httpGet action to ensure the pod is ready before starting to receive traffic
```yaml
...
spec:
    containers:
    - name: my-nginx
      image: nginx:alpine
      readinessProbe:
        httpGet:
            path: /
            port: 80
        initialDelaySeconds: 2
        periodSeconds: 5
```
