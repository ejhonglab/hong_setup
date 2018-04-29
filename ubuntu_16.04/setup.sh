#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# get current user so we can explicitly run commands that don't require
# root privileges as that user
if [ $SUDO_USER ]; then
    USER=$SUDO_USER
else
    USER=`whoami`
fi

apt update
# vim-gtk was compiled with system clipboard support, unlike vim-nox
apt install -y vim-gtk git xclip xdotool expect

# TODO maybe install conda instead?
# https://www.digitalocean.com/community/tutorials/
# how-to-install-the-anaconda-python-distribution-on-ubuntu-16-04
apt install -y python3-pip python3-venv direnv
# TODO some reason this seems to have been necessary on cthulhu but not other
# computers?
apt install -y python3-tk

# TODO install dotfiles from github thing
# TODO install conda in a way that won't conflict with ROS?

# missing:
# arduino

# change setting for multiple workspaces, only current icons visible,

# vlc?

# make Amazon application icon hidden in dashboard search
# can't install package that contains it (unity-webapps-common)
# because it has other important stuff
sudo -u $USER cp /usr/share/applications/ubuntu-amazon-default.desktop \
    ~/.local/share/applications/ubuntu-amazon-default.desktop
echo Hidden=true >> ~/.local/share/applications/ubuntu-amazon-default.desktop

sudo -u $USER mkdir -p ~/src
sudo -u $USER mkdir -p ~/catkin/src

# TODO install mendeley?
# TODO same shortcuts in mendeley
# TODO install firefox w/ settings (vim keybinds, etc)
# TODO how to configure tridactyl 
# (only that works for newest firefox as of late 2017)
# to have ":bind i tabclose"?
# also:
# :bind h tableft -1
# :bind l tableft

sudo -u $USER git config --global user.name "Tom O'Connell"
sudo -u $USER git config --global user.email "toconnel@caltech.edu"

# TODO get path to this script first? (to not use relative)
if [ ! -e ~/.ssh/id_rsa.pub ]; then
    ${SCRIPTPATH}/mk_key.sh
else
    echo "SSH key found. Not generating for Github. See ~/src/scripts/mk_key.sh"
fi

# TODO make these the systemwide defaults?
sudo -u $USER ./ui_settings.sh
sudo -u $USER ./google_drive_links.sh
