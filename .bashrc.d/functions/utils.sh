function osim_ip_info() {
  curl https://ipapi.co/$1/json/ | jq
}

function osim_extract() {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
  else
    for n in "$@"; do
      if [ -f "$n" ]; then
        case "${n%,}" in
        *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
          tar xvf "$n"
          ;;
        *.lzma) unlzma ./"$n" ;;
        *.bz2) bunzip2 ./"$n" ;;
        *.rar) unrar x -ad ./"$n" ;;
        *.gz) gunzip ./"$n" ;;
        *.zip) unzip ./"$n" ;;
        *.z) uncompress ./"$n" ;;
        *.7z | *.arj | *.cab | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.rpm | *.udf | *.wim | *.xar)
          7z x ./"$n"
          ;;
        *.xz) unxz ./"$n" ;;
        *.exe) cabextract ./"$n" ;;
        *)
          echo "extract: '$n' - unknown archive method"
          return 1
          ;;
        esac
      else
        echo "'$n' - file does not exist"
        return 1
      fi
    done
  fi
}

function require_root() {
  if (($EUID != 0)); then
    echo "Please run as root or via sudo..."
    exit 1
  fi
}

function exists() {
  command -v "$1" >/dev/null 2>&1
}

function select_user() {
  echo $(awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd | gum choose)
}

function append_line_to_file_if_line_not_present() {
  LINE="${1}"
  THE_FILE="${2}"
  grep -qF -- "$LINE" "$THE_FILE" || echo "$LINE" >>"$THE_FILE"
}

function configure_passwordless_sudo() {
  USER=$(gum input "Enter username:")
  echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
}

function add_user() {
  USER=$(gum input "Enter username:")
  SHELL=$(cat /etc/shells | gum choose)

  if [ -z "$USER" ]; then
    echo "User cannot be empty"
    return
  fi

  if getent passwd $USER; then
    echo "User \"$USER\" already exists..."
  else
    useradd --create-home --shell "$SHELL" "$USER"
  fi
}

function configure_timezone() {
  # This will only work in an environment featuring systemd. WSL will throw an error. It's okay
  if [[ $(grep -i microsoft /proc/version) ]]; then
    echo "You are running inside WSL (Windows Subsystem for Linux). No need to set timezone - this is automatically injected by Windows..."
    return
  fi
  SELECTED_TIMEZONE=$(timedatectl list-timezones | gum choose)
  timedatectl set-timezone "$SELECTED_TIMEZONE"
}
