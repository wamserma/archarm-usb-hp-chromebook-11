#!/bin/bash
REPOPATH="https://raw.githubusercontent.com/wamserma/archarm-usb-hp-chromebook-11/master/"

# Update pacman and install some important things
pacman -Syyu
if !(which wget)
then
	pacman -Sy wget
fi
pacman -S ttf-dejavu lxde xorg-server xorg-xinit xorg-server-utils xterm alsa-utils xf86-video-fbdev xf86-input-libinput gvfs
echo "exec startlxde" > ~/.xinitrc
systemctl enable lxdm.service

echo "run alsamixer as root and unmute all the Speaker-Channels (3 groups of 4 for Left and Right each)"

pacman -S wicd wicd-gtk
systemctl enable wicd

echo "uncomment your domain (e.g. DE) in /etc/conf.d/wireless-regdom"

# Add xorg.conf entries for screen and touchpad
cd /etc/X11/xorg.conf.d/
wget ${REPOPATH}10-monitor.conf
wget ${REPOPATH}50-touchpad.conf

# other useful programs/software I use often
pacman -S screen base-devel git gnupg openvpn wicd wicd-gtk mlocate cifs-utils pv rsync ntfs-3g clusterssh diffuse gksu
pacman -S geany libreoffice-fresh firefox firefox-i18n-de mutt mupdf lynx mpg123
pacman -S llvm r pari

# apacman from aur
pushd /tmp
wget https://aur.archlinux.org/cgit/aur.git/snapshot/apacman.tar.gz
tar xf apacman.tar.gz && cd apacman 
makepkg -A
pacman -U apacman*.pkg.tar.xz
popd

# from aur: haroopad;remarkable killed a file because it had issues with encoding

# more audio
pacman -S pulseaudio pulseaudio-alsa

# the non-10-bit libc264 for vlc
pacman -S libx264
pacman -S vlc

# fonts I like
pacman -S adobe-source-code-pro-fonts

# MTA
# https://flexion.org/posts/2013-03-nullmailer-on-arch-linux/
# use a special SMTP account for outgoing mail
pacman -S nullmailer
echo "set up /etc/nullmailer/remotes"
echo "set up /etc/nullmailer/defaultdomain"
echo "set /etc/nullmailer/allmailfrom to your relay email-account"
echo "set /etc/nullmailer/adminaddr to an address where you want to catch all local deliveries"

# backup!
pacman -S cronie tarsnap
apacman -S acts
systemctl enable cronie
systemctl start cronie
echo "configure acts and add to /etc/anacrontab"
