function install_vcluster_cli() {
  if exists vcluster; then
    echo "vCluster CLI already installed..."
    return
  fi

  cd $(mktemp -d)
  curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64"
  sudo install -c -m 0755 vcluster /usr/local/bin
  sudo /usr/local/bin/vcluster completion bash | sudo tee /etc/bash_completion.d/vcluster.sh
  cd -
}

# Installing via kubectl apply
# kubectl create namespace host-namespace-1
# helm template my-vcluster vcluster --repo https://charts.loft.sh -n host-namespace-1 | kubectl apply -f -
