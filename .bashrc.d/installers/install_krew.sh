function install_krew() {
  if exists kubectl-krew; then
    echo "Krew already installed..."
    return
  fi

  echo "Installing Krew (Kubectl plugin manager)..."

  set -x
  export KREW_ROOT="${HOME}/krew"
  OS="$(uname | tr '[:upper:]' '[:lower:]')"
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
  KREW="krew-${OS}_${ARCH}"
  cd "$(mktemp -d)"
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
  tar zxvf "${KREW}.tar.gz"
  ./"${KREW}" install krew
  sudo ln -s "${HOME}/krew/bin/kubectl-krew" /usr/local/bin/kubectl-krew
  sudo ln -s "${HOME}/krew/bin/kubectl-krew" /usr/local/bin/krew

  export PATH="${PATH}:${HOME}/.krew/bin"
  export KREW_ROOT="${HOME}/krew"

  krew completion bash | sudo tee /etc/bash_completion.d/krew.sh

  RC_FILE="~/.bashrc.d/krew.sh"
  echo 'export PATH="${PATH}:${HOME}/.krew/bin"' >"${RC_FILE}"
  echo 'export KREW_ROOT="${HOME}/krew"' >>"${RC_FILE}"
  cd -
}
