function install_k9s() {
  if exists k9s; then
    echo "K9s already installed..."
    return
  fi

  echo "Installing K9s..."
  cd $(mktemp -d)
  curl -Lo k9s.tgz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz
  tar -xf k9s.tgz
  sudo install k9s /usr/local/bin
  k9s completion bash | sudo tee /etc/bash_completion.d/k9s.sh
  cd -
}
