install_docker_compose() {
    if exists docker-compose; then
        echo "Docker compose already installed..."
        return
    fi

    echo "Installing Docker compose..."

    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    DC_VERSION=$(docker-compose --version | grep -oP "[0-9]+\.[0-9]+\.[0-9]+")
    curl -L https://raw.githubusercontent.com/docker/compose/${DC_VERSION}/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
}