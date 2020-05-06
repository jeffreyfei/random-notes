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



