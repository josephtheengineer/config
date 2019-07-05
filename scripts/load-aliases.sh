cd-ls()
{
        cd $1 && ls -a
}

hidden-ls()
{
        if [ -f .hidden ]; then
                #ls | sed -e 's/Desktop//g'
                #ls | grep -v "Desktop" #sed -e 's/\n//g'
                #ls | grep -v '^[D]'
                ls -I {Desktop,workspace}*
        fi
}

git-sync()
{
        git add .
        git commit -m "$1"
        git push
}

install-font()
{
        cp -r $1 ~/.local/share/fonts/
        ls ~/.local/share/fonts
}

set-wallpaper()
{
        sway output eDP-1 bg $1 fill
}

help()
{
        echo '=== MAINTENANCE ==='
        echo ' network'
        echo ' update'
        echo ' config'
        echo ' rebuild'
        echo '=== FILESYSTEM ==='
        echo ' file-manager'
        echo ' ls'
        echo ' cd'
        echo ' rm'
        echo ' cp'
        echo ' mv'
        echo ' editor'
        echo '=== ADMIN ==='
        echo ' task-manager'
        echo ' system-monitor'
        echo '=== ENTERTAINMENT ==='
        echo ' discord'
        echo ' web-browser'
        echo '=== MISC ==='
        echo ' refresh'
        echo ' clear'
}

RUN_SCRIPT="$XDG_CONFIG_HOME/scripts/run-script.sh"

# scripts
alias system-info="$RUN_SCRIPT system-info"
alias config="$RUN_SCRIPT configure"
alias mount-drive="$RUN_SCRIPT mount-drive"
alias umount-drive="$RUN_SCRIPT umount-drive"

# sortcuts
alias network='nmtui'
alias update='sudo nixos-rebuild switch --upgrade --repair'
alias config='sudo nvim /etc/nixos/configuration.nix'
alias refresh='clear; neofetch; date; ls'
alias cd='cd-ls'
alias rm='rm -i'
alias task-manager='htop'
alias system-monitor='gotop'
alias file-manager='ranger'
alias rebuild='sudo nixos-rebuild switch'
alias discord='Discord'
alias web-browser='firefox'
alias e='nvim'
alias alsamixer='alsamixer -g'

# folders
alias school='~/workspace/josephtheengineer.ddns.net/school'
