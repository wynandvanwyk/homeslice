function install_terraform_versions_via_tfenv() {
  # Terraform installs managed by tfenv
  data_file=~/.data/my_terraform_versions.list

  tfenv init
  if [ -f ~/.data/my_terraform_versions.list ]; then
    for tf_version in $(cat "${data_file}"); do
      tfenv install $tf_version
    done
  else
    tf_versions=$(tfenv list-remote | gum choose --no-limit)
    for tf_version in $tf_versions; do
      tfenv install $tf_version
      echo $tf_version >>"${data_file}"
    done
  fi
  echo "Choose default Terraform version..."
  default_version=$(tfenv list | gum choose)
  tfenv use $default_version

  echo 'complete -C "~/tfenv/versions/$(terraform version -json | jq -r ".terraform_version")/terraform" terraform' | sudo tee ~/.bashrc.d/terraform.sh
}

# This is silly. Use tfenv instead
function install_terraform_standalone() {
  if exists terraform; then
    echo "Terraform already installed..."
    return
  fi

  echo "Installing Terraform..."

  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt-get -y update
  sudo apt-get -y install terraform
  echo 'complete -C terraform terraform' | sudo tee ~/.bashrc.d/terraform.sh
}
