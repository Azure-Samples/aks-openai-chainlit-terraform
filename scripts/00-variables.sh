# Azure Subscription and Tenant
subscriptionId=$(az account show --query id --output tsv)
subscriptionName=$(az account show --query name --output tsv)
tenantId=$(az account show --query tenantId --output tsv)

# Variables
acrName="PaolosAcr"
acrResourceGrougName="PaolosRG"
location="eastus"
attachAcr=false

# Python Files
docsAppFile="docs.py"
chatAppFile="chat.py"

# Docker Images
docsImageName="chainlitdocs"
chatImageName="chainlitchat"
tag="v1"
port="8000"
imagePullPolicy="Always" # Always, Never, IfNotPresent

# Arrays
images=($docsImageName $chatImageName)
filenames=($docsAppFile $chatAppFile)

# Managed Identity
managedIdentityName="PaolosWorkloadManagedIdentity"
federatedIdentityName="ChainlitFederatedIdentity"

# Parameters
temperature="0.9"
imageWidth="80"

# OpenAI
openAiName="PaolosOpenAi "
openAiResourceGroupName="PaolosRG"
openAiType="azure_ad"
openAiKey=""
openAiVersion="2023-12-01-preview"
openAiBase="https://Paolosopenai.openai.azure.com/"
openAiChatDeployment="gpt-35-turbo-16k"
openAiChatModel="gpt-35-turbo-16k"
openAiChatSystemMessage="You are a helpful assistant."
openAiEmbeddingsDeployment="text-embedding-ada-002"

# NGINX Ingress Controller installed via Helm
nginxNamespace="ingress-basic"
nginxRepoName="ingress-nginx"
nginxRepoUrl="https://kubernetes.github.io/ingress-nginx"
nginxChartName="ingress-nginx"
nginxReleaseName="ingress-nginx"
nginxReplicaCount=3

# NGINX Ingress Controller installed via AKS application routing add-on
webAppRoutingNamespace="app-routing-system"
webAppRoutingServiceName="nginx"

# Certificate Manager
cmNamespace="cert-manager"
cmRepoName="jetstack"
cmRepoUrl="https://charts.jetstack.io"
cmChartName="cert-manager"
cmReleaseName="cert-manager"

# Cluster Issuer
email="paolos@microsoft.com"
clusterIssuerNames=("letsencrypt-nginx" "letsencrypt-webapprouting")
clusterIssuerTemplates=("cluster-issuer-nginx.yml" "cluster-issuer-webapprouting.yml")

# AKS Cluster
aksClusterName="PaolosAks"
aksResourceGroupName="PaolosRG"

# Sample Application
namespace="chainlit"
serviceAccountName="chainlit-sa"

# Ingress and DNS
dnsZoneName="babosbird.com"
dnsZoneResourceGroupName="DnsResourceGroup"
docsSubdomain="docs"
chatSubdomain="chat"

# Specify the ingress class name for the ingress controller.
# - nginx: unmanaged NGINX ingress controller installed vuia Helm
# - webapprouting.kubernetes.azure.com: managed NGINX ingress controller installed via AKS application routing add-on
ingressClassName="webapprouting.kubernetes.azure.com"

if [[ $ingressClassName == "nginx" ]]; then
  # Specify the name of the ingress objects.
  chatIngressName="chat-ingress-nginx"
  docsIngressName="docs-ingress-nginx"

  # Specify the cluster issuer name for the ingress controller.
  clusterIssuer="letsencrypt-nginx"

  # Specify the name of the secret that contains the TLS certificate for the ingress controller.
  chatIngressSecretName="chat-tls-secret-nginx"
  docsIngressSecretName="docs-tls-secret-nginx"
else
  # Specify the name of the ingress objects.
  chatIngressName="chat-ingress-webapprouting"
  docsIngressName="docs-ingress-webapprouting"

  # Specify the cluster issuer name for the ingress controller.
  clusterIssuer="letsencrypt-webapprouting"

  # Specify the name of the secret that contains the TLS certificate for the ingress controller.
  chatIngressSecretName="chat-tls-secret-webapprouting"
  docsIngressSecretName="docs-tls-secret-webapprouting"
fi
