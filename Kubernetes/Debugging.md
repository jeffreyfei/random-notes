# Debugging

## Logging Commands
```bash
# Follow pod logs
kubectl logs -f [pod-name]

# Show specific number of log lines
kubectl logs --tail=20 [pod-name]

# Return logs newer than a relative point in time
kubectl logs --since=10s [pod-name]

# Return logs for entries for pods with specific labels
kubectl logs -l app=backend --all-containers=true

# Show snapshot of logs from a previously terminated container in a Pod
# e.g. debugging in a restart situation
kubectl logs -p -c [container-name] [pod-name]
```

## Get Pod Information
```bash
# Describe a pod
kubectl describe pod [pod-name]

# Change a Pod's output format
kubectl get pod [pod-name] -o yaml

# Change a Deployment's output format
kubectl get deployment [deployment-name] -o wide

# Get specific Pod events
kubectl get events --field-selector type=warning --all-namespaces

# Get specific Pod information (json)
kubectl get pods --namespace default -o jsonpath="{.spec.containers[*].image}"
```

## Debugging
```bash
# Shell into a Pod container
kubectl exec [pod-name] -it -- sh

# Create a copy of Pod with debugging utilities and change command
# Useful to debug a crashed container
kubectl debug myapp -it --copy-to=myapp-debug --container=myapp -- sh

```
