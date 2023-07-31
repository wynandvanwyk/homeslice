install_neovim() {

  if exists neovim; then
    echo "Neovim already installed..."
    return
  fi

  echo "Installing Neovim..."

  sudo apt-get -y install neovim
}
