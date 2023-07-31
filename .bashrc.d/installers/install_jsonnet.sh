function install_jsonnet() {
  if exists jsonnet; then
    echo "Jsonnet already installed..."
    return
  fi

  echo "Installing Jsonnet..."
  cd $(mktemp -d)
  LATEST_VERSION=$(curl --silent "https://api.github.com/repos/google/go-jsonnet/releases/latest" | jq ".. .tag_name? // empty" | tr -d '"')
  curl -Lo jsonnet_latest.tar.gz "https://github.com/google/go-jsonnet/releases/latest/download/go-jsonnet_${LATEST_VERSION:1}_Linux_x86_64.tar.gz"

  tar -xf jsonnet_latest.tar.gz
  rm jsonnet_latest.tar.gz
  chmod a+x jsonnet*
  sudo mv jsonnet* /usr/local/bin/

  # jsonnet bundler
  sudo curl -Lo /usr/local/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/latest/download/jb-linux-amd64
  sudo chmod a+x /usr/local/bin/jb

  cd -
}
