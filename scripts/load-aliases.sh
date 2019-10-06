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

paperless-server()
{
	paperless runserver &
	paperless document_consumer
}

RUN_SCRIPT="$XDG_CONFIG_HOME/scripts/run-script.sh"

# scripts
alias cleanup="$RUN_SCRIPT cleanup"

for file in $XDG_CONFIG_HOME/scripts/*
do
	filename=$(basename $file .sh)
	alias $filename="$RUN_SCRIPT $filename"
done

# sortcuts
alias network='nmtui'
alias update='sudo nixos-rebuild switch --upgrade --repair --keep-going'
alias config='sudo nvim /etc/nixos/configuration.nix'
alias refresh='clear; neofetch; date; ls'
alias cd='cd-ls'
alias rm='rm -i'
alias reboot='echo "Rebooting `hostname` in 5 seconds. Press Ctrl+C to cancel";sleep 7 && reboot'
alias poweroff='echo "Shutting down `hostname` in 5 seconds. Press Ctrl+C to cancel";sleep 7 && poweroff'
alias task-manager='htop'
alias system-monitor='gotop'
alias file-manager='ranger'
alias rebuild='sudo nixos-rebuild switch --keep-going'
alias discord='Discord'
alias web-browser='firefox'
alias e='nvim'
alias c='configure'
alias alsamixer='alsamixer -g'
alias scan='sudo scanimage -p --format=png --resolution=300 >/var/spool/scans/$(date +%Y%m%d%H%M%S)Z_p%04d.png'
alias icat="kitty +kitten icat"
alias lsblk='lsblk -o name,size,mountpoint,uuid'

# folders
alias school='~/workspace/josephtheengineer.ddns.net/school'
