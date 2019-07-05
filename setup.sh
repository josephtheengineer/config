sudo rm -rf /etc/nixos/configuration.nix
sudo ln -s ~/.config/nixos/configuration.nix /etc/nixos/configuration.nix

sudo rm -rf /etc/nixos/local-configuration.nix
sudo ln -s ~/.config/nixos/local-configuration.nix /etc/nixos/local-configuration.nix

cat ~/.config/sway/local-vars ~/.config/sway/main \
    ~/.config/sway/local > ~/.config/sway/config


#wget -P ~/fonts https://github.com/belluzj/fantasque-sans/releases/download/v1.7.2/FantasqueSansMono-Normal.tar.gz
