#!/bin/bash

# before running this, run atlas_postinstall1.sh
# after reboot, run atlast_postinstall2.sh
# TODO maybe have the former register this to be run upon reboot?

# Enable the partner repo
sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
sudo apt update

# Install other packages
sudo apt install -y git vlc texstudio openssh-server

# Install updates
sudo apt -y full-upgrade
sudo reboot
