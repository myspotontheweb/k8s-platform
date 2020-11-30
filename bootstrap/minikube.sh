
#
# Start a minikube cluster
#
minikube start --driver=docker --kubernetes-version=v1.16.15

#
# Enable and configure Ingress
#
minikube addons enable ingress

kubectl patch deploy ingress-nginx-controller -n kube-system -p '[{"op":"add","path":"/spec/template/spec/containers/0/args/8","value":"--enable-ssl-passthrough"}]' --type json

#
# Install ArgoCD
#
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f - <<END
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: argocd-server-ingress
  namespace: argocd
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
spec:
  rules:
  - host: argocd.test
    http:
      paths:
      - backend:
          serviceName: argocd-server
          servicePort: https
        path: /
  tls:
  - hosts:
    - argocd.test
    secretName: argocd-secret # do not change, this is provided by Argo CD
END

#
# Bootstrap platform
#
kubectl apply -f bootstrap/application.yaml

#
# Wait for Argo CD to be ready
#
kubectl -n argocd wait --for condition=ready pods -l app.kubernetes.io/name=argocd-server --timeout=180s

