#!/usr/bin/env sh

# TITTLE       : install_vnc-server.sh
# DESCRIPTION  : install the vnc-server in the rpi3 with kali
# AUTHOR       : rcebs
# DATE         : 2017-09-26
# VERSION      : 1.0
# USAGE        : sh install_vnc-server.sh
# NOTES        : Install vim to edit this script, if you want to use this script
#                   with other user, you need to change the user in the
#                   config/tightvncserver file with the new user
# BASH VERSION : 4.3.48(1)-release

#============================================================================
# Check if root
if [ "$(whoami)" != "root" ]; then
  whiptail --msgbox "Sorry you are not root. You must type: sudo sh install_vnc-server.sh" 10 60
  exit
fi

# Install and configure
apt install -y tightvncserver
cp $(pwd)/tightvncserver /etc/init.d/tightvncserver

# Modify permissions
chmod 755 /etc/init.d/tightvncserver
update-rc.d tightvncserver defaults
update-rc.d tightvncserver enable

# Setup a password for vnc
vncpasswd

/etc/init.d/tightvncserver start

if (whiptail --title "REBOOT" --yesno "Want to reboot now?" --yes-button "Yes" --no-button "No" 10 60) then
    poweroff --reboot || shutdown -h now
else
    exit
fi
