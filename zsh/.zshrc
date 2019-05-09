# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	sway
	exit 0
fi

gpg-connect-agent /bye
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export MPD_HOST=/run/mpd/socket

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="/run/user/$USER"
export EDITOR="vim"

compinit -d "$XDG_DATA_HOME/zsh/zcompdump"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
)

$XDG_CONFIG_HOME/scripts/load-aliases.sh

system-info --startup

neofetch
#fortune | cowsay
date
ls

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
