rm ~/.zshrc
ln -s ~/config/zsh.conf ~/.zshrc
#rm ~/.config/sway/config
#ln -s ~/config/sway.conf ~/.config/sway/config

cat $HOME/config/sway.conf \
    $HOME/config/sway.local.conf > $HOME/.config/sway/config


rm ~/.config/rofi/config
ln -s ~/config/rofi.conf ~/.config/rofi/config
rm ~/.config/termite/config
ln -s ~/config/termite.conf ~/.config/termite/config

# oh my zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#wget -P ~/fonts https://github.com/belluzj/fantasque-sans/releases/download/v1.7.2/FantasqueSansMono-Normal.tar.gz

rm ~/.config/gtk-3.0/gtk.css
ln -s ~/dotfiles/gtk.conf ~/.config/gtk-3.0/gtk.css
