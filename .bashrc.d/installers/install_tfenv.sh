install_tfenv() {

    if exists tfenv; then
        echo "Tfenv already installed..."
        return
    fi

    echo "Installing Tfenv..."
    git clone --depth=1 https://github.com/tfutils/tfenv.git /home/$1/tfenv
    ln -s /home/$1/tfenv/bin/tfenv /usr/local/bin/tfenv
    ln -s /home/$1/tfenv/bin/terraform /usr/local/bin/terraform
    chown -R $1:$1 /home/$1/tfenv
}