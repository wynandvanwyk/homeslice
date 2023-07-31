#!/bin/bash

install_vcluster_cli() {
    if exists vcluster; then
        echo "vCluster CLI already installed..."
        return
    fi

    cd $(mktemp -d)
    curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64"
    install -c -m 0755 vcluster /usr/local/bin
    /usr/local/bin/vcluster completion bash > /etc/bash_completion.d/vcluster_bash_completion
}

#Installing via kubectl apply
# kubectl create namespace host-namespace-1
# helm template my-vcluster vcluster --repo https://charts.loft.sh -n host-namespace-1 | kubectl apply -f -