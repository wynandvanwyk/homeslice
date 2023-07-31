# command replacements

alias top="htop"
alias df="pydf"
alias vi="vim"
alias diff="colordiff"

# often used one-liners

alias osim_terragrunt_providers_lock="terragrunt providers lock"
alias osim_ports_listening='netstat -tulanp | grep LISTEN'
alias osim_public_ip='curl -s ifconfig.me'
alias osim_flushdns='resolvectl flush-caches'
alias osim_aws_vault='AWS_PROFILES=$(aws-vault list --profiles); AWS_SELECTED_PROFILE=$(gum choose ${AWS_PROFILES}); aws-vault exec "${AWS_SELECTED_PROFILE}" --duration 1h'
alias pwn='if $(gum confirm "Are you sure you want to take ownership of this directory and all sub directories?"); then sudo chown -R $USER . ; fi'

# improve command defaults

alias less="less -F"
alias ping='ping -c 5'
alias mkdir="mkdir -pv"
alias wget="wget --continue"
alias du="du -ch"
alias ls='ls -CHG --color'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# safety

alias rm='rm -i --verbose --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# shortcuts

alias s="source ~/.bashrc; source /etc/bash_completion.d/*"
alias r='reset; clear; tput reset; stty sane; echo -e "\033c"' # fix a borked terminal
alias c='clear'
alias ll="ls -ahl"
alias h="cd ~"
alias x="exit"
alias f='find . | grep -i '    # find file in current directory
alias hiss='history| grep -i ' # search history
alias p="export PS1='\W\$ '"   # shorten prompt
alias j='jobs -l'
alias sudo='sudo ' # make aliases available when using sudo
alias rt='sudo -i'
alias svim="sudo vim"

# tools

alias t="terraform"
alias tg="terragrunt"
alias tgl="terragrunt providers lock"
alias k="kubectl"
alias g="git"
alias gc='git commit -m'
alias ga='git add'
alias gu='git pull'
alias gp='git push'
alias gs='git status'
alias gd='git diff'
alias d="docker"
alias dc="docker-compose"
alias e="code . &"
alias aws-vault="aws-vault --backend=file --prompt=terminal"

# navigation

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'

# firewall

alias ipt='sudo /sbin/iptables'
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

# misc

alias meminfo='free -m -l -t'
alias cpuinfo='lscpu'
alias psmem='ps auxf | sort -nr -k 4 | head -10' # get top 10 memory hogs
alias pscpu='ps auxf | sort -nr -k 3 | head -10' # get top 10 cpu hogs
