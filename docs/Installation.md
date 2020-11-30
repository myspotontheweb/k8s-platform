
Table of Contents
=================

   * [Table of Contents](#table-of-contents)
   * [Software tools](#software-tools)
   * [Minikube](#minikube)
      * [/etc/hosts](#etchosts)
      * [Reset ArgoCD password](#reset-argocd-password)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# Software tools

* kubectl
* minikube
* argocd

# Minikube

Run the bootstrap script that will startup minikube and install the platform tools

```
. bootstrap/minikube.sh
```

## /etc/hosts

Setup IP addresses for ingress end-points

```
echo "$(minikube ip) argocd.test argo.test minio.test" | sudo tee -a /etc/hosts
```

## Reset ArgoCD password

Retrieve initial password

```
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
```

Login as "admin"

```
argocd login argocd.test --insecure
```

Change the password

```
argocd account update-password
```

