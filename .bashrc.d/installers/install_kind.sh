install_kind() {
    if exists kind; then
        echo "Kind already installed..."
        return
    fi

    echo "Installing Kind..."
    curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/latest/download/kind-linux-amd64
    chmod +x ./kind
    mv ./kind /usr/local/bin/kind
}