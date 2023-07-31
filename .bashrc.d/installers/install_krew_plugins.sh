function install_krew_plugins() {
  if [ -f ~/.data/my_krew_plugins.list ]; then
    kubectl-krew install <~/.data/my_krew_plugins.list
  fi
  additional_plugins=$(kubectl krew search | gum choose --no-limit | awk '{print $1}')
  echo $additional_plugins >>~/.data/my_krew_plugins.list
  kubectl-krew install $additional_plugins
}
