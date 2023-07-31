install_azure_cli() {
  if exists aws; then
    echo "AWS CLI already installed..."
    return
  fi

  apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
  curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg >/dev/null
  AZ_REPO=$(lsb_release -cs)
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list
  apt-get -y update
  apt-get -y install azure-cli
}
