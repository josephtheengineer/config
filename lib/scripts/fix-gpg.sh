export GPG_TTY=$(tty)
./$LIB/scripts/pinentry-update.sh
gpgconf –kill gpg-agent
pkill pinentry
pkill gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
