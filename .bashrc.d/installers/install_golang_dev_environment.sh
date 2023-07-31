install_golang_dev_environment() {
  if exists go; then
      echo "Go already installed..."
      return
  fi
  LATEST_VERSION=$(curl -s "https://go.dev/dl/?mode=json" | jq -r '.[0].version')
  wget -O go.tar.gz "https://go.dev/dl/${LATEST_VERSION}.linux-amd64.tar.gz"
  tar -C /usr/local -xzf go.tar.gz
  INSTALL_FOR_USER=$(select_user)
  HOME_DIR=$(getent passwd "${INSTALL_FOR_USER}" | cut -d: -f6)
  append_line_to_file_if_line_not_present 'export PATH="$PATH:/usr/local/go/bin"' "${HOME_DIR}/.profile"
}