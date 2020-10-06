#!/bin/sh

# setup yay
echo -c "Install new software..."
yay -S xorg-server xorg-server-common xorg-xinit xcompmgr tmux minicom networkmanager blueman net-tools python sudo termite xorg-xkbcomp xorg-xmodmap xorg-xprop xorg-xrandr xorg-xrdb xscreensaver xsensors xorg-setxkbmap \
    # xf86-video-intel \
    ttf-droid ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-font-awesome ttf-liberation ttf-opensans ttf-ubuntu-font-family ttf-nerd-fonts-symbols-mono\
    sddm i3-gaps i3blocks dmenu rofi feh scrot pcmanfm\
    google-chrome mpd mpc ncmpc vim ctags p7zip vlc iperf ristretto libreoffice anydesk-bin wireshark-qt \

echo -c "Copy configuration files..."
cp ./bashrc ~/.bashrc
cp ./tmux.conf ~/.tmux.conf
cp ./vimrc ~/.vimrc
# i3wm config
mkdir -p ~/.config/i3
cp i3/config ~/.config/i3
cp i3/i3blocks.conf ~/.config/i3
cp -R i3/scripts ~/.config/i3
cp i3/setkb ~/.config/i3
# rofi config
mkdir -p ~/.config/rofi
cp config/rofi/config ~/.config/rofi
# termite config
mkdir -p ~/.config/termite
cp config/termite/config ~/.config/termite

