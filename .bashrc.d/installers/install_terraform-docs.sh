function install_terraform_docs() {
  if exists terraform-docs; then
    echo "terraform-docs CLI already installed..."
    return
  fi

  echo "Installing terraform-docs CLI..."

  LATEST_TERRAFORM_DOCS_VERSION=$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -oP '"tag_name": "[v]\K(.*)(?=")')
  cd $(mktemp -d)
  curl -fsSLO "https://github.com/terraform-docs/terraform-docs/releases/download/v${LATEST_TERRAFORM_DOCS_VERSION}/terraform-docs-v${LATEST_TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz"
  # TODO: Fix this version hard coding
  tar -xvf terraform-docs-v0.16.0-linux-amd64.tar.gz
  chmod +x terraform-docs
  sudo mv terraform-docs /usr/local/bin/terraform-docs

  terraform-docs completion bash | sudo tee /etc/bash_completion.d/terraform-docs.sh
  cd -
}
