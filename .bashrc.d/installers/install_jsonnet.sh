install_jsonnet() {
    if exists jsonnet; then
        echo "Jsonnet already installed..."
        return
    fi

    echo "Installing Jsonnet..."
    cd $(mktemp -d)
    LATEST_VERSION=$(curl --silent "https://api.github.com/repos/google/go-jsonnet/releases/latest" | jq ".. .tag_name? // empty" | tr -d '"')
    curl -Lo jsonnet_latest.tar.gz "https://github.com/google/go-jsonnet/releases/latest/download/go-jsonnet_${LATEST_VERSION:1}_Linux_x86_64.tar.gz"

    tar -xf jsonnet_latest.tar.gz
    rm jsonnet_latest.tar.gz
    chmod a+x jsonnet*
    mv jsonnet* /usr/local/bin/

    # jsonnet bundler
    curl -Lo /usr/local/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/latest/download/jb-linux-amd64
    chmod a+x /usr/local/bin/jb
}

install_grafana_tanka() {
    if exists tk; then
        echo "Tanka already installed..."
        return
    fi
    curl -Lo /usr/local/bin/tk https://github.com/grafana/tanka/releases/latest/download/tk-linux-amd64
    chmod a+x /usr/local/bin/tk
    tk complete
}