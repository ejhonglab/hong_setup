#!/usr/bin/env bash

# get the name of the current script
this_script="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

# verify script was invoked with sudo (/ current user is root)
# , since we will not ask for a password later
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Run this script with 'sudo ./${this_script}'"
    exit
fi

# get current user so we can explicitly run commands that don't require
# root privileges as that user
if [ $SUDO_USER ]; then
    USER=$SUDO_USER
else
    USER=`whoami`
fi

# TODO break into 80 char lines, if possible
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key \
    421C365BD9FF1F717815A3895523BAEEB01FA116
apt update

apt-get install -y ros-kinetic-ros-base

apt-get install -y python-rosinstall python-rosinstall-generator python-wstool \
    build-essential

# https://answers.ros.org/question/32875/rosdep-command-not-found/
#apt-get install python-rosdep
# TODO why wasn't preceding requirement mentioned in install? still relvant w/
# either of the desktop packages? mention for sake of people installing base?
# maybe it's not necessary?
rosdep init
sudo -u $USER rosdep update

sudo -u $USER mkdir -p ~/catkin/src
# TODO https by default?
cd ~/catkin/src
sudo -u $USER git clone git@github.com:tom-f-oconnell/multi_tracker.git
# TODO build / cd necessary?
rosdep install -y multi_tracker

# only append if not in already there
# TODO what wasn't working here?
sudo -u $USER $(grep -q -F '/opt/ros/kinetic/setup.bash' ~/.bashrc || \
    echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc)
source ~/.bashrc

cd ~/src
sudo -u $USER git clone git@github.com:florisvb/FlyPlotLib.git
cd FlyPlotLib
python setup.py install

