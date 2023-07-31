install_copyq() {
  if ! exists copyq; then
    sudo add-apt-repository ppa:hluk/copyq
    sudo apt update
    sudo apt install copyq
  fi
}
