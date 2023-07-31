install_krew_plugins() {
    sudo -i -u $1 bash << EOF
    echo "Installing Kubectx (Krew plugin for Kubectl)..."
    kubectl-krew install ctx
    echo "Installing Kubens (Krew plugin for Kubectl)..."
    kubectl-krew install ns
EOF
}