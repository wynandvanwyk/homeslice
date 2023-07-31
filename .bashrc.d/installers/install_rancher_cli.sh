install_rancher_cli() {
    if exists rancher; then
        echo "Rancher CLI already installed..."
        return
    fi

    echo "Installing Rancher CLI..."
    
    LATEST_RANCHER_VERSION=$(wget -qO- https://github.com/rancher/cli/releases | grep -oP "rancher-darwin-amd64-v[0-9]+\.[0-9]+\.[0-9]+\.tar.gz" | head -n 1 | grep -oP "[0-9]+\.[0-9]+\.[0-9]+")
    cd $(mktemp -d)
    wget -qO- https://github.com/rancher/cli/releases/download/v${LATEST_RANCHER_VERSION}/rancher-linux-amd64-v${LATEST_RANCHER_VERSION}.tar.gz | tar xvz
    mv ./rancher-v*/rancher /usr/local/bin/
}