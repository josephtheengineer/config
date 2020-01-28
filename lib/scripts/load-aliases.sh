# You may also like to assign a key to this command:
#
#     bind '"\C-o":"lfcd\C-m"'  # bash
#     bindkey -s '^o' 'lfcd\n'  # zsh
#

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

cd-ls()
{
        cd $1 && ls -a
}

git-sync()
{
        git add .
        git commit -m "$1"
        git push
}

install-font()
{
        cp -r $1 $LIB/fonts/
        ls $LIB/fonts
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

function rsyncmv
{
	rsync --partial --progress --append --rsh=ssh -r -h --remove-sent-files "$@" && rm -rf $1
}

function cp-progress
{
	cp $@ & progress -mp $!
}

function mv-progress
{
	mv $@ & progress -mp $!
}

RUN_SCRIPT="$LIB/scripts/run-script.sh"

# scripts
for file in $LIB/scripts/*
do
	filename=$(basename $file .sh)
	alias $filename="$RUN_SCRIPT $filename"
done

# projects workspace
for file in ~/workspace/*
do
	filename=$(basename $file)
	alias $filename="source ~/.config/scripts/open-project.sh $filename"
done

# projects workspace
for file in $PLAN9/bin/*
do
	alias $file="$PLAN9/bin/$filename"
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
alias reload-agent='gpg-connect-agent reloadagent /bye'
alias icat="kitty +kitten icat"
alias lsblk='lsblk -o name,size,mountpoint,uuid'
alias rcp="rsync --partial --progress --append --rsh=ssh -r -h"
alias rmv="rsyncmv"
#alias cp="cp-progress"
#alias mv="mv-progress"
alias ls-size="ls --human-readable --size -1 -S --classify"
alias clear-swap="sudo swapoff -a && sudo swapon -a"
alias find-gateway="route -n | grep 'UG[ \t]' | awk '{print $2}'"

# Linux commands
#alias cat="$PLAN9/bin/cat"

# folders
alias school='~/workspace/josephtheengineer.ddns.net/school'
