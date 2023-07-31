function install_my_apt_packages() {
  if [ -f ~/.data/my_apt_packages.list ]; then
    SELECTED_APT_PACKAGES=$(cat ~/.data/my_apt_packages.list | gum choose --no-limit)
    sudo apt-get -y update
    sudo apt-get -y install $SELECTED_APT_PACKAGES
  fi
}
