install_docker() {
    if exists docker; then
        echo "Docker already installed..."
        return
    fi

    echo "Installing Docker..."

    local DISTRO=$(lsb_release -cs)
    #Workaround while jammy does not yet have an offial docker repository (use focal instead)
    # if [ ${DISTRO}=="jammy" ]; then
    #     DISTRO="focal"
    # fi

    # echo ${DISTRO}
    
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $DISTRO stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update -y
    apt-get install -y docker-ce docker-ce-cli containerd.io
    getent group docker || groupadd docker
    usermod -aG docker $1
    newgrp docker
}