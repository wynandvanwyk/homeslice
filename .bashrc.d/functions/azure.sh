function osim_azure_get_public_ips() {
  az account list -o json | jq ".[] .id" | sed s/\"//g | while read -r id; do
    az account set --subscription $id --output none
    az network public-ip list -o table
  done
}

function osim_azure_get_kubeconfigs() {
  az account list -o json | jq ".[] .id" | sed s/\"//g | while read -r id; do
    az account set --subscription $id --output none
    az aks list -o json | jq -r '.[] | "\(.name) \(.resourceGroup)"' | while read -r name resourceGroup; do
      az aks get-credentials --name $name --resource-group $resourceGroup --file "~/.kube/${name}.yaml"
    done
  done
}
