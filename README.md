##########  After Applying Argocd  ############ 
kubectl -n argocd patch deployment argocd-server   --type='json'   -p='[{"op":"replace","path":"/spec/template/spec/containers/0/args","value":["--insecure"]},{"op":"replace","path":"/spec/template/spec/containers/0/command","value":["argocd-server"]}]'

 kubectl patch svc argocd-server   -n argocd   -p '{"spec": {"type": "NodePort"}}'

 OR Change in Helm 
