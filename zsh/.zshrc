#                 ██                    
#                ░██                    
#  ██████  ██████░██      ██████  █████ 
# ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#    ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░ 
#   ██    ░░░░░██░██  ░██ ░██   ░██   ██
#  ██████ ██████ ░██  ░██░███   ░░█████ 
# ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░  

# ~/.config/zsh/.zshrc
# man zsh

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	sway
	exit 0
fi

#export PINENTRY_USER_DATA="USE_CURSES=1"
#GPG_TTY=$(tty)
#export GPG_TTY
gpg-connect-agent /bye
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export MPD_HOST=/run/mpd/socket

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_RUNTIME_DIR="/run/user/$USER"

# Declare XDG-FHS
#export XDG_CACHE_HOME="~/.local/var/cache"
#export XDG_CONFIG_HOME="~/.local/etc"
#export XDG_DATA_HOME="~/.local/share"
#export XDG_STATE_HOME="~/.local/var/lib"
#export XDG_LIB_HOME="~/.local/lib"
#export XDG_LOG_HOME="~/.local/var/log"


#export XDG_RUNTIME_DIR="/run/user/$USER"
export EDITOR="nvim"

compinit -d "$XDG_DATA_HOME/zsh/zcompdump"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
)

source $XDG_CONFIG_HOME/scripts/load-aliases.sh

system-info --startup
