install_helm() {
    if exists helm; then
        echo "Helm already installed..."
        return
    fi

    echo "Installing Helm..."
    
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    helm completion bash > /etc/bash_completion.d/helm_bash_completion
}