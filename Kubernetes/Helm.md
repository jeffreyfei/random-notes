# Helm Package Manager

**Chart** - Bundle of information used to create an instance of a Kubernetes application

**Config** - Configuration information htat can be merged into a packaged chart to create a releasable object

**Release** - Running instance of a chart (combined with a specific configuration) in Kubernetes


## Commands
```
# Find charts and repos
helm search hub [KEYWORD] [flags] 
helm repo add [NAME] [URL]
helm search repo

# Learn about chart values
helm show values
helm pull --untar

# Install, upgrade, uninstall a chart
helm install [NAME] [CHART/REPO] [flags]
helm upgrade [NAME] [CHART/REPO] --version [new-version]
helm uninstall [NAME]
```
