#!/bin/bash

cd /tmp
mkdir mainline_kernel_4.15
cd mainline_kernel_4.15
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.15.4/linux-headers-4.15.4-041504_4.15.4-041504.201802162207_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.15.4/linux-headers-4.15.4-041504-generic_4.15.4-041504.201802162207_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.15.4/linux-image-4.15.4-041504-generic_4.15.4-041504.201802162207_amd64.deb
sudo dpkg -i *.deb
sudo update-grub
sudo reboot
