function install_direnv() {
  if ! exists direnv; then
    sudo apt-get -y update
    sudo apt-get -y install direnv
  fi
  echo 'eval "$(direnv hook bash)"' >~/.bashrc.d/direnv.sh
}
