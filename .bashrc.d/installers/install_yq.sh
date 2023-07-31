install_yq() {
    if exists yq; then
        echo "yq already installed..."
        return
    fi
    cd $(mktemp -d)
    curl -Lo yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
    chmod a+x ./yq
    mv ./yq /usr/local/bin/yq
}