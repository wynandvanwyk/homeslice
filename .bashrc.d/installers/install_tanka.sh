function install_tanka() {
  if exists tk; then
    echo "Tanka already installed..."
    return
  fi

  sudo curl -Lo /usr/local/bin/tk https://github.com/grafana/tanka/releases/latest/download/tk-linux-amd64
  sudo chmod a+x /usr/local/bin/tk
  tk complete
  echo 'complete -C /usr/local/bin/tk tk' >~/.bashrc.d/tanka.sh
}
