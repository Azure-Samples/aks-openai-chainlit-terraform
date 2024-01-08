# Variables
source ./00-variables.sh
subdomains=($docsSubdomain $chatSubdomain)

# Install jq if not installed
path=$(which jq)

if [[ -z $path ]]; then
    echo 'Installing jq...'
    apt install -y jq
fi

# Choose the ingress controller to use
if [[ $ingressClassName == "nginx" ]]; then
    ingressNamespace=$nginxNamespace
    ingressServiceName="${nginxReleaseName}-controller"
else
    ingressNamespace=$webAppRoutingNamespace
    ingressServiceName=$webAppRoutingServiceName
fi

# Retrieve the public IP address of the NGINX ingress controller
echo "Retrieving the external IP address of the [$ingressClassName] NGINX ingress controller..."
publicIpAddress=$(kubectl get service -o json -n $ingressNamespace |
    jq -r '.items[] | 
    select(.spec.type == "LoadBalancer" and .metadata.name == "'$ingressServiceName'") |
    .status.loadBalancer.ingress[0].ip')

if [ -n "$publicIpAddress" ]; then
    echo "[$publicIpAddress] external IP address of the [$ingressClassName] NGINX ingress controller successfully retrieved"
else
    echo "Failed to retrieve the external IP address of the [$ingressClassName] NGINX ingress controller"
    exit
fi

for subdomain in ${subdomains[@]}; do
    # Check if an A record for todolist subdomain exists in the DNS Zone
    echo "Retrieving the A record for the [$subdomain] subdomain from the [$dnsZoneName] DNS zone..."
    ipv4Address=$(az network dns record-set a list \
        --zone-name $dnsZoneName \
        --resource-group $dnsZoneResourceGroupName \
        --query "[?name=='$subdomain'].ARecords[].ipv4Address" \
        --output tsv \
        --only-show-errors)

    if [[ -n $ipv4Address ]]; then
        echo "An A record already exists in [$dnsZoneName] DNS zone for the [$subdomain] subdomain with [$ipv4Address] IP address"

        if [[ $ipv4Address == $publicIpAddress ]]; then
            echo "The [$ipv4Address] ip address of the existing A record is equal to the ip address of the ingress"
            echo "No additional step is required"
            continue
        else
            echo "The [$ipv4Address] ip address of the existing A record is different than the ip address of the ingress"
        fi
        # Retrieving name of the record set relative to the zone
        echo "Retrieving the name of the record set relative to the [$dnsZoneName] zone..."

        recordSetName=$(az network dns record-set a list \
            --zone-name $dnsZoneName \
            --resource-group $dnsZoneResourceGroupName \
            --query "[?name=='$subdomain'].name" \
            --output tsv \
            --only-show-errors 2>/dev/null)

        if [[ -n $recordSetName ]]; then
            echo "[$recordSetName] record set name successfully retrieved"
        else
            echo "Failed to retrieve the name of the record set relative to the [$dnsZoneName] zone"
            exit
        fi

        # Remove the A record
        echo "Removing the A record from the record set relative to the [$dnsZoneName] zone..."

        az network dns record-set a remove-record \
            --ipv4-address $ipv4Address \
            --record-set-name $recordSetName \
            --zone-name $dnsZoneName \
            --resource-group $dnsZoneResourceGroupName \
            --only-show-errors 1>/dev/null

        if [[ $? == 0 ]]; then
            echo "[$ipv4Address] ip address successfully removed from the [$recordSetName] record set"
        else
            echo "Failed to remove the [$ipv4Address] ip address from the [$recordSetName] record set"
            exit
        fi
    fi

    # Create the A record
    echo "Creating an A record in [$dnsZoneName] DNS zone for the [$subdomain] subdomain with [$publicIpAddress] IP address..."
    az network dns record-set a add-record \
        --zone-name $dnsZoneName \
        --resource-group $dnsZoneResourceGroupName \
        --record-set-name $subdomain \
        --ipv4-address $publicIpAddress \
        --only-show-errors 1>/dev/null

    if [[ $? == 0 ]]; then
        echo "A record for the [$subdomain] subdomain with [$publicIpAddress] IP address successfully created in [$dnsZoneName] DNS zone"
    else
        echo "Failed to create an A record for the $subdomain subdomain with [$publicIpAddress] IP address in [$dnsZoneName] DNS zone"
    fi
done
