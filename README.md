# My dotfiles

Log into a fresh Ubuntu 22.04 LTS server installation and clone this repository:

```
sudo apt install git
git clone https://github.com/tonstein/dots ~
```

Copy the files in ~/dots to your home folder ~.

You now have this README.md file to copy the following commands.

First install:

```
sudo apt install vim htop ranger xterm rxvt-unicode git xinit x11-xserver-utils unzip xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev suckless-tools xmobar rofi qutebrowser nitrogen picom lxappearance
```

Download the LiterationMono Nerd Fonts:

```
mkdir -p ~/.local/share/fonts/LiberationMono
cd $_
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/LiberationMono.zip
unzip LiberationMono.zip
rm LiberationMono.zip
```

Set your timezone, e.g.:

```
sudo timedatectl set-timezone Europe/Berlin
```

Download a wallpaper, e.g.:

```
mkdir -p ~/pictures/wallpapers
cd $_
wget -O 01.jpg https://images.unsplash.com/photo-1524802414218-3983cd08ed53?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80
```

Setup vim-plug:

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim
```

In vim execute `:PlugInstall` and `:qa`. Then you're ready to start xmonad:

```
startx
```
