# User bins
[ -d "${HOME}/bin" ] && export PATH="${HOME}/bin:${PATH}"
[ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:${PATH}"

# Rust
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"

# Golang
[ -d "/usr/local/go/bin" ] && export PATH="${PATH}:/usr/local/go/bin"
[ -d "${HOME}/go/bin" ] && export PATH="${PATH}:${HOME}/go/bin"

# Krew plugin manager for Kubectl
[ -d "${HOME}/.krew/bin" ] && export PATH="${PATH}:${HOME}/.krew/bin"

# Version manager for Terraform
[ -d "/usr/local/tfenv/bin" ] && export PATH="${PATH}:/usr/local/tfenv/bin"
