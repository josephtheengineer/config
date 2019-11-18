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
export GPG_TTY=$(tty)
gpg-connect-agent /bye
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-connect-agent updatestartuptty /bye # Fix GPG ssh login

export MPD_HOST=/run/mpd/socket
export EDITOR="nvim"

compinit -d "$CACHE/zsh/zcompdump"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
)

source $LIB/scripts/load-aliases.sh

system-info --startup
