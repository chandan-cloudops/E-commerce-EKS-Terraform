#!/bin/bash
for dir in \
  cloudwatchagent-fluentbit-terraform-manifests \
  cluster-autoscaler-install-terraform-manifests \
  ebs-addon-terraform-manifests \
  ebs-terraform-manifests \
  k8s-metrics-server-terraform-manifests \
  lbc-install-terraform-manifests \
  01-ekscluster-terraform-manifests; do
  if [ -d "$dir" ]; then
    echo "Destroying Terraform in $dir"
    cd "$dir" || exit
    terraform destroy -auto-approve
    cd ..
  fi
done
