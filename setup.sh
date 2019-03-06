rm ~/.zshrc
ln -s ~/dotfiles/zsh.config ~/.zshrc
rm ~/.config/sway/config
ln -s ~/dotfiles/sway.config ~/.config/sway/config
rm ~/.config/rofi/config
ln -s ~/dotfiles/rofi.config ~/.config/rofi/config
rm ~/.config/termite/config
ln -s ~/dotfiles/termite.config ~/.config/termite/config

# oh my zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#wget -P ~/fonts https://github.com/belluzj/fantasque-sans/releases/download/v1.7.2/FantasqueSansMono-Normal.tar.gz

