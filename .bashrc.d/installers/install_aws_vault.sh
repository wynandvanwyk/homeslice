function install_aws_vault() {
  if exists aws-vault; then
    echo "AWS Vault already installed..."
    return
  fi
  cd $(mktemp -d)
  echo "Installing AWS Vault..."
  LATEST_AWS_VAULT_VERSION=$(curl -s https://api.github.com/repos/99designs/aws-vault/releases/latest | grep -oP '"tag_name": "[v]\K(.*)(?=")')
  curl -fsSLO https://github.com/99designs/aws-vault/releases/download/v${LATEST_AWS_VAULT_VERSION}/aws-vault-linux-amd64
  sudo mv aws-vault-linux-amd64 /usr/local/bin/aws-vault
  sudo chmod +x /usr/local/bin/aws-vault
  cd -
}
