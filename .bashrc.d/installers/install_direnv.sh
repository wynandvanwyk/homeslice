install_direnv() {
  if ! exists direnv; then
    sudo apt-get install -y direnv
    echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
  fi
}
