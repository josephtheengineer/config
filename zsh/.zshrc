# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
  cat $HOME/config/sway.conf \
    $HOME/config/sway.local.conf > $HOME/.config/sway/config
	sway
	exit 0
fi

gpg-connect-agent /bye
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Add scripts dir
export PATH=$PATH:~/scripts

export MPD_HOST=/run/mpd/socket

# Path to your oh-my-zsh installation.
export ZSH="/home/josephtheengineer/.config/oh-my-zsh"

compinit -d "/home/josephtheengineer/.local/share/zsh/zcompdump"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
#HIST_STAMPS="dd-mm-yyyy"
#HISTFILE=~/.zsh-history

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

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
