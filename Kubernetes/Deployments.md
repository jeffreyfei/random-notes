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