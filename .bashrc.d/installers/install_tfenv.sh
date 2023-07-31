function install_tfenv() {
  if exists tfenv; then
    echo "Tfenv already installed..."
    return
  fi

  echo "Installing Tfenv..."
  git clone --depth=1 https://github.com/tfutils/tfenv.git "${HOME}/tfenv"
  sudo ln -s "${HOME}/tfenv/bin/tfenv" /usr/local/bin/tfenv
  sudo ln -s "${HOME}/tfenv/bin/terraform" /usr/local/bin/terraform

  echo 'export PATH="${PATH}:/usr/local/tfenv/bin"' >"${HOME}/.bashrc.d/tfenv.sh"
}
