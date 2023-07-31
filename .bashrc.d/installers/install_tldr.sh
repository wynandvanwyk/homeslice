function install_tldr() {
  if exists tldr; then
    echo "TLDR already installed..."
    return
  fi

  echo "Installing TLDR..."
  sudo apt-get -y install npm
  sudo npm install -g tldr
}
