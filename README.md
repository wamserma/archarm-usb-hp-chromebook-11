TL;DR:
======

Use these directions to install to a USB stick, then just load splat.sh (http://git.io/vcNSH) and run it to install to eMMC.

You get the default ALARM user accounts. (root/root and alarm/alarm).


NOTE
======

**This is a fork of Max Glenister's work for playing around. For latest versions, questions etc. have a look at his repo, solved issues and wiki at https://github.com/omgmog/archarm-usb-hp-chromebook-11**

This repo also integrates my fork/snapshot/copy of @starkers method. (`splat.sh`) which is  based off the steps here: http://archlinuxarm.org/platforms/armv7/samsung/samsung-chromebook

The post-install-script is heavily tailored to my personal preferences.

## To use this script

On your Chromebook with Developer Mode enabled:

```
sudo su -
cd /tmp
wget https://raw.githubusercontent.com/wamserma/archarm-usb-hp-chromebook-11/master/install.sh -O install.sh
bash install.sh "/dev/sda"
```
**NOTE**: This needs to be run with /bin/bash, not /bin/sh, which is ash.

After you've made a USB stick and booted from it, you can download and run Starkers' `splat.sh` and install to `/dev/mmcblk0` (the eMMC) for a much nicer/faster Arch experience.

Log in as the *root* user which was created during the install process.  Then, select which wifi network to join:
```
wifi-menu mlan0
```

Then, download and run the install script, but this time on the internal storage:
```
pacman -Syy wget
wget http://git.io/vcNSH -O splat.sh
chmod +x splat.sh
./splat.sh /dev/mmcblk0
```
(there should not be any need for running ```dev_install``` and ```emerge parted```)
