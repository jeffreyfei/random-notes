# Deployments

- ReplicaSets act as a Pod controller
- Deployment is a wrapper around replica sets
- Support zero-downtume updates by creating / destroying ReplicaSets
- Support rollback

Deployments can utilize selectors to select all templates with the matching labels
```yaml
...
spec:
    selector:
        matchLabels:
            tier: frontend
...
```
## Key Configurations
- maxSurge - the maximum number of extra pods allowed during a rolling update with respect to the number of replicas
    - e.g. if replicas = 2 and maxSurge = 1 then the most pods that we can have during an update is 3
- maxUnavailable - the max number of pods that can be unavailable during an update with respect to the number of replicas
    - e.g. if replicas = 2 and maxUnavailable = 1 then the least pods that we can have during an update is 1

## Commands
Get deployment alongside their respective labels
```
kubectl get deployment --show-labels
```

Scaling deployment
```
# Scale the deployment pods to 5
kubectl scale deployment [deployment-name] --replicas=5

# Scale by referencing a yaml file
kubectl scale -f file.deployment.yml --replicas=5
```

You can also configure replicas in the yaml file
```yaml
...
spec:
    replicas: 3
...
```

Quickly create a template file from a dry-run command

```
kubectl create deploy [deployment-name] --image=[image-name]:[tag] --dry-run=client -o yaml > deploy.yaml
```

Set selector on a resource
```
kubectl set selector svc [service-name] 'key=value'
```

Change the image in a deployment
```
kubectl set image deploy [deployment-name] [image-name]
```

Edit the configuration of a resource
```
kubectl edit deploy [deployment-name]
```

Create initial deployment and save the configuration of the deployment in the resources annotation
- This saves a history of the deployment to an annotation section in the output yaml
```
kubectl create -f [deployment-file] --save-config
```

Apply changes to a deployment and record the change to the annotations
- Note: the `--record` flag is marked as deprecated
```
kubectl apply -f [deployment-file] --record=true
```

### Rollout Commands

```bash
# Check status
kubectl rollout status -f [deployment-file]

# Get rollout history
kubectl rollout history -f [deployment-file]
kubectl rollout history deploy [deploy-name]

# Roll back deployment to the previous version
kubectl rollout undo -f [deployment-file]

# Roll back deployment to the a specific version
kubectl rollout undo -f [deployment-file] --to-revision=2
```
