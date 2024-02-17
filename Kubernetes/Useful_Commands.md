# Useful Commands

#### Show all pods with labels

`kubectl get pods --show-labels`

#### Show pods with specific label

`kubectl get pods --selector <key>=<value>`

* `--selector` can be replaced with `-l` 

* Selectors can be chained using `,`
* `!=` - not equals

* `<key> in (<value1>, <value2>)` - or statement
  * Can also be used with the `notin` operator

`kubectl delete pods -l <key>=<value>`

* Deletes the pods with a given label

### Troubleshooting Pods
```bash
# Get pod information in yaml format
kubectl get pod [pod-name] -o yaml

# Detailed description of a specific pod
kubectl describe pod [pod-name]

# Connect into the shell of a specific pod
kubectl exec [pod-name] -it sh
```

### Log viewing
```bash
# Get logs of the running pod
kubectl logs [pod-name]

# Get logs of a specific container within a running log
kubectl logs [pod-name] -c [container-name]

# Get logs of a previously running pod (currently not running)
kubectl logs -p [pod-name]

# Follow the logs of a currently running pod
kubectl logs -f [pod-name]
```

