install_kubectl() {
    if exists kubectl; then
        echo "Kubectl already installed..."
        return
    fi

    echo "Installing Kubectl..."
    
    cd $(mktemp -d)
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    kubectl completion bash > /etc/bash_completion.d/kubectl_bash_completion
}