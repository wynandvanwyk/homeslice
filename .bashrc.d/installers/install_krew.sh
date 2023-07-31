install_krew() {
    if exists kubectl-krew; then
        echo "Krew already installed..."
        return
    fi

    echo "Installing Krew (Kubectl plugin manager)..."

    set -x; 
    export KREW_ROOT="/home/$1/krew"
    OS="$(uname | tr '[:upper:]' '[:lower:]')"
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
    KREW="krew-${OS}_${ARCH}"
    cd "$(mktemp -d)"
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
    tar zxvf "${KREW}.tar.gz"
    ./"${KREW}" install krew
    ln -s /home/$1/krew/bin/kubectl-krew /usr/local/bin/kubectl-krew
    ln -s /home/$1/krew/bin/kubectl-krew /usr/local/bin/krew
    chown -R $1:$1 /home/$1/krew
}