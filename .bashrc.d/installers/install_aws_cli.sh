function install_aws_cli() {
  if exists aws; then
    echo "AWS CLI already installed..."
    return
  fi

  echo "Installing AWS CLI..."
  cd $(mktemp -d)
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm -rf ./aws
  rm -rf ./awscliv2.zip

  echo "complete -C '/usr/local/bin/aws_completer' aws" | sudo tee /etc/bash_completion.d/aws.sh
  cd -
}
