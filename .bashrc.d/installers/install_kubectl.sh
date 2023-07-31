function install_kubectl() {
  if exists kubectl; then
    echo "Kubectl already installed..."
    return
  fi

  echo "Installing Kubectl..."

  cd $(mktemp -d)
  LATEST_STABLE_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
  curl -LO "https://dl.k8s.io/release/${LATEST_STABLE_VERSION}/bin/linux/${ARCH}/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl.sh
  cd -
}
