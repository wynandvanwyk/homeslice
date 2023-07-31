function install_govc() {
  if exists govc; then
    echo "Govc already installed..."
    return
  fi
  echo "Installing govc..."
  cd $(mktemp -d)
  LATEST_VERSION=$(curl --silent "https://api.github.com/repos/vmware/govmomi/releases/latest" | jq ".. .tag_name? // empty" | tr -d '"')
  wget "https://github.com/vmware/govmomi/releases/download/${LATEST_VERSION}/govc_Linux_x86_64.tar.gz"

  tar -xf govc_Linux_x86_64.tar.gz
  rm -f govc_Linux_x86_64.tar.gz
  chmod a+x govc
  sudo mv --force govc /usr/local/bin/
  cd -
}
