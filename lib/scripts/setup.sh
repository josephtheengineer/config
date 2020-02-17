sudo rm -rf /etc/nixos/configuration.nix
sudo ln -s $ETC/nixos/configuration.nix /etc/nixos/configuration.nix

cat $ETC/sway/local-vars $ETC/sway/main \
    $ETC/sway/local > $ETC/sway/config

#wget -P ~/fonts https://github.com/belluzj/fantasque-sans/releases/download/v1.7.2/FantasqueSansMono-Normal.tar.gz
