RUN_SCRIPT="$XDG_CONFIG_HOME/scripts/run-script.sh"

# scripts
alias system-info="$RUN_SCRIPT system-info"

# sortcuts
alias network='nmtui'
alias update='sudo nixos-rebuild switch --upgrade'
alias config='sudo vim /etc/nixos/configuration.nix'
alias refresh='clear; neofetch; date; ls'
alias cd='cd-ls'
alias rm='rm -i'
alias task-manager='htop'
alias system-monitor='gotop'
alias file-manager='ranger'
alias rebuild='sudo nixos-rebuild switch'
alias discord='Discord'
alias web-browser='firefox'
alias editor='vim'
alias alsamixer='alsamixer -g'

