# My dotfiles

Log into a fresh Ubuntu 22.04 LTS server installation and run:

```
sudo apt install vim htop ranger xterm rxvt-unicode git xinit x11-server-utils
sudo apt install xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev suckless-tools xmobar rofi
sudo apt install qutebrowser 
sudo apt install nitrogen picom lxappearance
git clone https://github.com/tonstein/dots
mkdir -p ~/.local/share/fonts/LiberationMono && cd $_
wget https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/LiberationMono/complete
sudo timedatectl set-timezone Europe/Berlin
```
