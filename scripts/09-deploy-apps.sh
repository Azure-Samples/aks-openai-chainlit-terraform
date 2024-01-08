#!/bin/bash

# Variables
source ./00-variables.sh

# Attach ACR to AKS cluster
if [[ $attachAcr == true ]]; then
  echo "Attaching ACR $acrName to AKS cluster $aksClusterName..."
  az aks update \
    --name $aksClusterName \
    --resource-group $aksResourceGroupName \
    --attach-acr $acrName
fi

# Check if namespace exists in the cluster
result=$(kubectl get namespace -o jsonpath="{.items[?(@.metadata.name=='$namespace')].metadata.name}")

if [[ -n $result ]]; then
  echo "$namespace namespace already exists in the cluster"
else
  echo "$namespace namespace does not exist in the cluster"
  echo "creating $namespace namespace in the cluster..."
  kubectl create namespace $namespace
fi

# Create docs-configmap
cat docs-configmap.yml |
    yq "(.data.TEMPERATURE)|="\""$temperature"\" |
    yq "(.data.AZURE_OPENAI_TYPE)|="\""$openAiType"\" |
    yq "(.data.AZURE_OPENAI_KEY)|="\""$openAiKey"\" |
    yq "(.data.AZURE_OPENAI_VERSION)|="\""$openAiVersion"\" |
    yq "(.data.AZURE_OPENAI_BASE)|="\""$openAiBase"\" |
    yq "(.data.AZURE_OPENAI_DEPLOYMENT)|="\""$openAiChatDeployment"\" |
    yq "(.data.AZURE_OPENAI_MODEL)|="\""$openAiChatModel"\" |
    yq "(.data.AZURE_OPENAI_ADA_DEPLOYMENT)|="\""$openAiEmbeddingsDeployment"\" |
    kubectl apply -n $namespace -f -

# Create docs-deployment
cat docs-deployment.yml |
    yq "(.spec.template.spec.containers[0].image)|="\""$acrName.azurecr.io/$docsImageName:$tag"\" |
    yq "(.spec.template.spec.containers[0].imagePullPolicy)|="\""$imagePullPolicy"\" |
    yq "(.spec.template.spec.serviceAccountName)|="\""$serviceAccountName"\" |
    kubectl apply -n $namespace -f -

# Create docs-service
kubectl apply -f docs-service.yml -n $namespace

# Create docs-ingress
cat docs-ingress.yml |
  yq "(.metadata.name)|="\""$docsIngressName"\" |
  yq "(.metadata.annotations.\"cert-manager.io/cluster-issuer\")|="\""$clusterIssuer"\" |
  yq "(.spec.ingressClassName)|="\""$ingressClassName"\" |
  yq "(.spec.tls[0].hosts[0])|="\""$docsSubdomain.$dnsZoneName"\" |
  yq "(.spec.tls[0].secretName)|="\""$docsIngressSecretName"\" |
  yq "(.spec.rules[0].host)|="\""$docsSubdomain.$dnsZoneName"\" |
  kubectl apply -n $namespace -f -

# Create chat-configmap
cat chat-configmap.yml |
    yq "(.data.TEMPERATURE)|="\""$temperature"\" |
    yq "(.data.AZURE_OPENAI_TYPE)|="\""$openAiType"\" |
    yq "(.data.AZURE_OPENAI_KEY)|="\""$openAiKey"\" |
    yq "(.data.AZURE_OPENAI_VERSION)|="\""$openAiVersion"\" |
    yq "(.data.AZURE_OPENAI_BASE)|="\""$openAiBase"\" |
    yq "(.data.AZURE_OPENAI_DEPLOYMENT)|="\""$openAiChatDeployment"\" |
    yq "(.data.AZURE_OPENAI_MODEL)|="\""$openAiChatModel"\" |
    yq "(.data.AZURE_OPENAI_SYSTEM_MESSAGE)|="\""$openAiChatSystemMessage"\" |
    kubectl apply -n $namespace -f -

# Create chat-deployment
cat chat-deployment.yml |
    yq "(.spec.template.spec.containers[0].image)|="\""$acrName.azurecr.io/$chatImageName:$tag"\" |
    yq "(.spec.template.spec.containers[0].imagePullPolicy)|="\""$imagePullPolicy"\" |
    yq "(.spec.template.spec.serviceAccountName)|="\""$serviceAccountName"\" |
    kubectl apply -n $namespace -f -

# Create chat-service
kubectl apply -f chat-service.yml -n $namespace

# Create chat-ingress
cat chat-ingress.yml |
  yq "(.metadata.name)|="\""$chatIngressName"\" |
  yq "(.metadata.annotations.\"cert-manager.io/cluster-issuer\")|="\""$clusterIssuer"\" |
  yq "(.spec.ingressClassName)|="\""$ingressClassName"\" |
  yq "(.spec.tls[0].hosts[0])|="\""$chatSubdomain.$dnsZoneName"\" |
  yq "(.spec.tls[0].secretName)|="\""$chatIngressSecretName"\" |
  yq "(.spec.rules[0].host)|="\""$chatSubdomain.$dnsZoneName"\" |
  kubectl apply -n $namespace -f -