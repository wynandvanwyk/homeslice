function install_docker() {
  if exists docker; then
    echo "Docker already installed..."
    return
  fi

  echo "Installing Docker..."

  local DISTRO=$(lsb_release -cs)
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $DISTRO stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get -y update
  sudo apt-get -y install docker-ce docker-ce-cli containerd.io
  # TODO: Fix below
  # getent group docker || groupadd docker
  # usermod -aG docker $1
  # newgrp docker
}
