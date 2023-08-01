function install_hashicorp_vault() {
  if exists vault; then
    echo "Hashicorp Vault already installed..."
    return
  fi

  echo "Installing Hashicorp Vault..."

  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt-get install -y vault
  echo "complete -C '/usr/bin/vault' vault" | sudo tee /etc/bash_completion.d/hashicorp_vault.sh
  virtual_platform=$(sudo virt-what)
  if [ "${virtual_platform}" == "docker" ]; then
    # reinstall if docker to solve a weird bug https://github.com/hashicorp/vault/issues/10924
    sudo apt-get install --reinstall -y vault
  fi
}
