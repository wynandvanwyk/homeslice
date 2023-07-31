install_commonly_used_apt_packages() {
  APT_INSTALL=$(gum choose --no-limit "hddtemp" "lm-sensors" "direnv" "nmap" "diff" "pydf" "tree" "fzf" "gnupg" "software-properties-common" "curl" "bash-completion" "ntp" "mlocate" "git" "zip" "zsh" "jq" "iperf3" "ncdu" "xmlstarlet" "htop" "ioping" "iotop" "dnsutils" "cowsay" "wget" "apt-transport-https" "ca-certificates" "lsb-release")
  sudo apt-get update -y
  sudo apt-get install -y $APT_INSTALL
}
