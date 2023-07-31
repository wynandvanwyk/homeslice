function install_terragrunt() {
  if exists terragrunt; then
    echo "Terragrunt CLI already installed..."
    return
  fi

  echo "Installing Terragrunt CLI..."

  LATEST_TERRAGRUNT_VERSION=$(curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | grep -oP '"tag_name": "[v]\K(.*)(?=")')
  cd $(mktemp -d)
  curl -fsSLO "https://github.com/gruntwork-io/terragrunt/releases/download/v${LATEST_TERRAGRUNT_VERSION}/terragrunt_linux_amd64"
  mv terragrunt_linux_amd64 terragrunt
  chmod +x terragrunt
  sudo mv terragrunt /usr/local/bin/terragrunt
  cd -
}
