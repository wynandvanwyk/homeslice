install_hashicorp_vault() {
    if exists vault; then
        echo "Hashicorp Vault already installed..."
        return
    fi

    echo "Installing Hashicorp Vault..."
    
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - 
    apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" 
    apt-get install -y vault

    echo "complete -C '/usr/bin/vault' vault" > /etc/bash_completion.d/vault_cli_bash_completion
}