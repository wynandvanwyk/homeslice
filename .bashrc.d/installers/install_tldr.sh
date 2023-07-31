install_tldr() {
  if exists tldr; then
      echo "TLDR already installed..."
      return
  fi

  echo "Installing TLDR..."
  apt-get install -y npm
  sudo npm install -g tldr
}
