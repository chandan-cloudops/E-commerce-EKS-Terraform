#!/bin/bash
for dir in */; do
  if [ -d "$dir" ]; then
    echo "Applying Terraform in $dir"
    cd "$dir" || exit
    terraform init  -reconfigure
    terraform apply -auto-approve
    cd ..
  fi
done
