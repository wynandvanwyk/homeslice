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
}
