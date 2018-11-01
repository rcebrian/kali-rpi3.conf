#!/usr/bin/env sh

# TITTLE       : install_raspi-config.sh
# DESCRIPTION  : Automatize the first config to the rpi3
# AUTHOR       : rcebs
# DATE         : 2017-09-26
# VERSION      : 2.0
# USAGE        : sh install_raspi-config.sh
# NOTES        : Install vim to edit this script
# BASH VERSION : 4.3.48(1)-release

#============================================================================
# Check if root
if [ "$(whoami)" != "root" ]; then
  whiptail --msgbox "Sorry you are not root. You must type: sudo sh install_raspi-config.sh" 10 60
  exit
fi

# Check if raspi-config is installed
if [ $(dpkg-query -W -f='${Status}' raspi-config 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
  whiptail --msgbox "Raspi-config is already installed, try upgrading it within raspi-config..." 10 60
else
  wget https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20180406+1_all.deb -P /tmp
  apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils -y
  # Auto install dependancies on eg. ubuntu server on RPI
  apt-get install -fy
  dpkg -i /tmp/raspi-config_20160527_all.deb
  whiptail --msgbox "Raspi-config is now installed, run it by typing: sudo raspi-config" 10 60
fi

exit
