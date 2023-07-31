# Run an alpine pod on which tools can be installed and used for debugging
function osim_k8s_debug_pod() {
  cluster=$(gum choose $(kubectl config get-contexts -o name))
  kubectl config set-cluster "${cluster}"
  namespace=$(gum choose $(kubectl get namespaces -o json | jq -r '.items[].metadata.name'))
  kubectl config set-context --current --namespace="${namespace}"
  pod_name=$(gum choose $(kubectl get pods -o json | jq -r '.items[].metadata.name'))
  debug_pod_name="$pod_name-debug"
  replica_pod=true
  kubectl --namespace "${namespace}" debug "${pod_name}" --image alpine --stdin --tty --share-processes --copy-to "${debug_pod_name}"

  if gum confirm "Delete debug pod (which was a temporary replica of the real pod)?"; then
    kubectl --namespace "${namespace}" delete pod "${debug_pod_name}"
  fi
}

function osim_k8s_get_secret() {
  cluster=$(gum choose $(kubectl config get-contexts -o name))
  kubectl config set-cluster "${cluster}"
  namespace=$(gum choose $(kubectl get namespaces -o json | jq -r '.items[].metadata.name'))
  kubectl config set-context --current --namespace="${namespace}"
  secret=$(gum choose $(kubectl get secrets -o json | jq -r '.items[].metadata.name'))
  kubectl get secret "${secret}" -o json | jq -r '.data | map_values(@base64d)'
}

function osim_k8s_cluster_yaml_dump() {
  CLUSTER=$(kubectl-ctx | gum choose)
  kubectl-ctx ${CLUSTER}
  NAMESPACES=$(kubectl get -o json namespaces | jq '.items[].metadata.name' | sed "s/\"//g")
  CLUSTER_RESOURCES=$(kubectl api-resources --verbs=list --namespaced=false -o name)

  for NAMESPACE in ${NAMESPACES}; do
    NAMEPACE_RESOURCES=$(kubectl api-resources --verbs=list --namespaced=true -o name -n ${NAMESPACE})
    for RESOURCE_TYPE in ${NAMEPACE_RESOURCES}; do
      EXISTING_RESOURCES=$(kubectl -n ${NAMESPACE} get -o json ${RESOURCE_TYPE} | jq '.items[].metadata.name' | sed "s/\"//g")
      for EXISTING_RESOURCE in ${EXISTING_RESOURCES}; do
        dir="${CLUSTER}/${NAMESPACE}/${RESOURCE_TYPE}"
        mkdir -p "${dir}"
        kubectl -n ${NAMESPACE} get -o yaml ${RESOURCE_TYPE} ${EXISTING_RESOURCE} >"${dir}/${EXISTING_RESOURCE}.yaml"
      done
    done
  done
}

# Download and save a list of official helm repos from artifacthub to ~/.data/helm_repos.list
function osim_data_download_helm_repo_list() {
  start_index=0
  cd $(mktemp -d)
  echo -n "" >helm_repos
  fetched_items=1
  while [ $fetched_items -gt 0 ]; do
    curl --silent -X "GET" "https://artifacthub.io/api/v1/repositories/search?offset=${start_index}&limit=20&kind=0" -H "accept: application/json" >tmp.json
    echo "filtering out unverified publishers..."
    cat tmp.json | jq '.[] | select(.verified_publisher==true) | .url' | sed 's/"//g' | sed 's/"//g' >>helm_repos
    fetched_items=$(cat tmp.json | jq '. | length')
    echo "Fetched ${fetched_items} items..."
    start_index=$((start_index + 20))
    sleep 1s
  done
  echo "filtering out all oci repos..."
  grep -v '^oci' helm_repos >helm_repos_cleaned
  if gum confirm "Add helm repos to ~/.data/helm_repos.csv?"; then
    mkdir -p ~/.data
    mv -f helm_repos_cleaned ~/.data/helm_repos.list
  fi
}

function osim_helm_add_all_official_repos() {
  while read -r line; do
    repo_name=$(echo $RANDOM | md5sum | head -c 20)
    helm repo add "$repo_name" "$line" || true
  done <~/.data/helm_repos.list
}

function osim_helm_clean_all_repos() {
  helm repo list | grep -v '^NAME' | awk '{print $1}' | xargs -i sh -c "helm repo remove {} || true"
}
