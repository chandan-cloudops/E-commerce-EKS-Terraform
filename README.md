                                  #  After Applying Argocd  ##
kubectl -n argocd patch deployment argocd-server   --type='json'   -p='[{"op":"replace","path":"/spec/template/spec/containers/0/args","value":["--insecure"]},{"op":"replace","path":"/spec/template/spec/containers/0/command","value":["argocd-server"]}]'

 kubectl patch svc argocd-server   -n argocd   -p '{"spec": {"type": "NodePort"}}'

 OR Change in Helm 
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

             #  You can download the latest stable release by executing below steps:


VERSION=$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION)
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v$VERSION/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

argocd login argocd.cloudops.quest \
  --username admin \
  --password $(kubectl -n argocd get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d) \
  --grpc-web
