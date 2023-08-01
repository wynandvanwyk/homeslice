function install_python_dev_environment() {
  sudo apt-get -y update
  sudo apt-get -y install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
  sudo apt-get install python3 python3-pip

  # Install Poetry
  curl -sSL https://install.python-poetry.org | python3 -
  poetry completions bash | sudo tee /etc/bash_completion.d/poetry.sh

  # Install Pyenv
  curl https://pyenv.run | bash
  RC_FILE="${HOME}/.bashrc.d/pyenv.sh"
  touch "${RC_FILE}"
  echo 'export PYENV_ROOT="${HOME}/.pyenv"' >"${RC_FILE}"
  echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >>"${RC_FILE}"
  echo 'eval "$(pyenv init -)"' >>"${RC_FILE}"
  echo 'eval "$(pyenv virtualenv-init -)"' >>"${RC_FILE}"
  # command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  # eval "$(pyenv init -)"
}
