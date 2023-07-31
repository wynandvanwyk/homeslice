function install_golang_dev_environment() {
  if exists go; then
    echo "Go already installed..."
    return
  fi
  cd $(mktemp -d)
  LATEST_VERSION=$(curl -s "https://go.dev/dl/?mode=json" | jq -r '.[0].version')
  wget -O go.tar.gz "https://go.dev/dl/${LATEST_VERSION}.linux-amd64.tar.gz"
  sudo tar -C /usr/local -xzf go.tar.gz

  export PATH="${PATH}:/usr/local/go/bin"
  export PATH="${PATH}:${HOME}/go/bin"

  echo 'export PATH="${PATH}:/usr/local/go/bin"' >"${HOME}/.bashrc.d/golang.sh"
  echo 'export PATH="${PATH}:${HOME}/go/bin"' >>"${HOME}/.bashrc.d/golang.sh"
  cd -
}
