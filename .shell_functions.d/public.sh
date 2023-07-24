function osim_ip_info() {
  curl https://ipapi.co/$1/json/ | jq
}

function osim_azure_get_public_ips() {
  az account list -o json | jq ".[] .id" | sed s/\"//g | while read -r id; do
    az account set --subscription $id --output none
    az network public-ip list -o table
  done
}

function osim_docker_cleanup() {
  if $(gum confirm "would you like to delete all stopped docker containers?"); then
    docker rm $(docker ps -a -q)
  fi

  if $(gum confirm "would you like to delete all dangling docker images?"); then
    docker image prune
  fi

  if $(gum confirm "would you like to delete all unused docker images?"); then
    docker image prune --all
  fi

  if $(gum confirm "would you like to delete all unreferenced docker volumes?"); then
    docker volume prune
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

function extract() {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
  else
    for n in "$@"; do
      if [ -f "$n" ]; then
        case "${n%,}" in
        *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
          tar xvf "$n"
          ;;
        *.lzma) unlzma ./"$n" ;;
        *.bz2) bunzip2 ./"$n" ;;
        *.rar) unrar x -ad ./"$n" ;;
        *.gz) gunzip ./"$n" ;;
        *.zip) unzip ./"$n" ;;
        *.z) uncompress ./"$n" ;;
        *.7z | *.arj | *.cab | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.rpm | *.udf | *.wim | *.xar)
          7z x ./"$n"
          ;;
        *.xz) unxz ./"$n" ;;
        *.exe) cabextract ./"$n" ;;
        *)
          echo "extract: '$n' - unknown archive method"
          return 1
          ;;
        esac
      else
        echo "'$n' - file does not exist"
        return 1
      fi
    done
  fi
}
