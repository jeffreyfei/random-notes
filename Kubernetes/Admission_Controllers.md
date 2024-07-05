# Admission Controllers

- Sits on the Kube API server to process user / pod commands
- Can be used to customize what runs on the server, enforce policies, and provide additional validations
- You can view the current enabled controller at `/etc/kubernetes/manifests/kube-apiserver.yml` on the pod
    - You can also view this same information with `kubectl describe pod <pod-name>`

## Commands
```
# View kube-apiserver configuration
kubectl describe pod kube-apiserver -n kube-system

# View kube-apiserver admission plugins
kubectl describe pod kube-apiserver -n kube-system | grep enable-admission-plugins
```
