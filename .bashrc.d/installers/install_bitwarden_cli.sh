install_bitwarden_cli() {
  current_dir=$PWD
  if exists bw; then
    echo "Bitwarden CLI already installed..."
    return
  fi
  echo "Installing bitwarden CLI..."
  cd $(mktemp -d)
  wget -O bw.zip "https://vault.bitwarden.com/download/?app=cli&platform=linux"
  unzip bw.zip
  chmod +x ./bw
  sudo mv --force bw /usr/local/bin/bw
  rm -f ./bw.zip
  cd $current_dir
}
