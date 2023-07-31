function install_k3d() {
  if exists k3d; then
    echo "K3d already installed..."
    return
  fi

  echo "Installing k3d..."
  cd $(mktemp -d)
  LATEST_VERSION=$(curl --silent "https://api.github.com/repos/k3d-io/k3d/releases/latest" | jq ".. .tag_name? // empty" | tr -d '"')
  curl -Lo k3d "https://github.com/k3d-io/k3d/releases/download/${LATEST_VERSION}/k3d-linux-amd64"
  chmod a+x k3d
  sudo mv k3d /usr/local/bin/
  k3d completion bash | sudo tee /etc/bash_completion.d/k3d.sh
  cd -
}
