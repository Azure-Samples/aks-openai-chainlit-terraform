#/bin/bash

# Variables
source ./00-variables.sh

# Use a for loop to tag and push the local docker images to the Azure Container Registry
for index in ${!clusterIssuerNames[@]}; do
  # Check if the cluster issuer already exists
  result=$(kubectl get ClusterIssuer -o json | jq -r '.items[].metadata.name | select(. == "aaa")')

  if [[ -n $result ]]; then
    echo "[${clusterIssuerNames[$index]}] cluster issuer already exists"
    continue
  else
    # Create the cluster issuer
    echo "[${clusterIssuerNames[$index]}] cluster issuer does not exist"
    echo "Creating [${clusterIssuerNames[$index]}] cluster issuer..."
    cat ${clusterIssuerTemplates[$index]} |
      yq "(.spec.acme.email)|="\""$email"\" |
      kubectl apply -f -
  fi
done
