function install_direnv() {
  if ! exists direnv; then
    sudo apt-get -y update
    sudo apt-get -y install direnv
  fi
  # The file name is prefixed with zz to place it at the end of the list after the prompt has been set.
  echo 'eval "$(direnv hook bash)"' >~/.bashrc.d/zz_direnv.sh
}
