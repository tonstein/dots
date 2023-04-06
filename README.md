# My dotfiles

Log into a fresh Ubuntu 22.04 LTS server installation and run:

```
sudo apt install vim htop ranger xterm rxvt-unicode git xinit x11-xserver-utils unzip
sudo apt install xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev suckless-tools xmobar rofi
sudo apt install qutebrowser 
sudo apt install nitrogen picom lxappearance

git clone https://github.com/tonstein/dots ~
sudo mv ~/dots/ ~/..

mkdir -p ~/.local/share/fonts/LiberationMono && cd $_
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/LiberationMono.zip
unzip LiberationMono.zip && rm -rf LiberationMono.zip

sudo timedatectl set-timezone Europe/Berlin

mkdir -p ~/pictures/wallpapers && cd $_
wget https://images.unsplash.com/photo-1524802414218-3983cd08ed53?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80
mv 'photo-1524802414218-3983cd08ed53?ixlib=rb-4.0.3' 01.jpg

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim    # then :PlugInstall

startx
```
