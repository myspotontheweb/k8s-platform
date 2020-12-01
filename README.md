# k8s-platform

An example Dev platform deployed on k8s

Software setup:

* [Installation](docs/Installation.md)

The following software is installed onto the Kubernetes cluster:

* [Argo CD](https://argoproj.github.io/argo-cd/)
* [Argo Workflows](https://argoproj.github.io/argo/)
* [Argo Events](https://argoproj.github.io/argo-events/)
* [Minio](https://min.io/)
* [OpenFaas](https://www.openfaas.com/)

## Argo Projects

* https://argocd.test
* https://argo.test

## Minio

* https://minio.test

## OpenFaas

* https://gateway.openfaas.test
* https://prometheus.openfaas.test

The following command

```
kubectl -n openfaas get secret basic-auth -ogo-template='{{printf "echo %s | faas-cli login -g https://gateway.openfaas.test -u %s -s --tls-no-verify\n" (index .data "basic-auth-password"|base64decode) (index .data "basic-auth-user"|base64decode)}}'
```

Generates a CLI login

```
echo XXXXXXX | faas-cli login -g https://gateway.openfaas.test -u ZZZZZZ -s --tls-no-verify
```

Deploy some stuff

```
OPENFAAS_URL=https://gateway.openfaas.test

faas-cli deploy -f https://raw.githubusercontent.com/openfaas/faas/master/stack.yml --tls-no-verify
```
