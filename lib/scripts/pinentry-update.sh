pinentry_loc=$(ls /nix/store/ | grep pinentry | grep curses | head -1)

echo "enable-ssh-support
pinentry-program /nix/store/$pinentry_loc/bin/pinentry" > $LIB/gnupg/gpg-agent.conf
