function install_neovim() {
  if exists neovim; then
    echo "Neovim already installed..."
    return
  fi

  echo "Installing Neovim..."
  sudo apt-get -y update
  sudo apt-get -y install neovim

  # TODO: Add neovim config/plugins etc.
}
