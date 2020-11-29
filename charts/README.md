
# Charts directory

This directory contains copies of Helm charts that cannot be installed by ArgoCD

* [ArgoCD #1251](https://github.com/argoproj/argo-cd/issues/1251)

# Minio

Minio helm chart was downloaded as follows

```
helm repo add minio https://helm.min.io/
rm -rf charts/minio
helm pull minio/minio --untar --untardir charts
```

All references to the Capabilities helm function call were then removed manually from the following files

```
$ find charts/minio -type f -exec grep -l Capabilities {} \;
charts/minio/templates/_helpers.tpl
charts/minio/templates/clusterroles.yaml
charts/minio/templates/securitycontextconstraints.yaml
charts/minio/templates/rolebindings.yaml
```

