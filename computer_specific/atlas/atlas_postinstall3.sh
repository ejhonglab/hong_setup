#!/bin/bash

# Clean apt
# TODO necessary with a basically new system?
sudo apt autoremove
sudo apt clean

# Set static IP
# Open browser, go to gateway.hong and login with admin account
# Status -> DHCP Leases -> Add Static Mapping
# Fill in "IP Address" with a valid 10.0.0.* address and check "ARP Table Static Entry"
# Press "Save" and "Apply Changes"

# Mount Synology network share
# Files -> Other Locations -> storage
# login admin and navigate to main

# Also install miniconda and dropbox (details change over time)

# Install matlab
# Download and extract linux 64-bit files
xhost si:localuser:root # wayland needs change to run X apps as root
sudo ./install

# Create new conda env
conda create -n py2 python=2
conda install -c https://conda.anaconda.org/simpleitk SimpleITK
