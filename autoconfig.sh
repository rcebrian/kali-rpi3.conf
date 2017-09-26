#!/usr/bin/env sh

# TITTLE       : autoconfig.sh
# DESCRIPTION  : Automatize the first config to the rpi3
# AUTHOR       : rcebs
# DATE         : 2017-09-26
# VERSION      : 1.0
# USAGE        : sh autoconfig.sh
# NOTES        : Install vim to edit this script
# BASH VERSION : 4.3.48(1)-release

#============================================================================
# Check if root
if [ "$(whoami)" != "root" ]; then
  whiptail --msgbox "Sorry you are not root. You must type: sudo sh autoconfig.sh" 10 60
  exit
fi

# Resize the partition to use all the disk
resize2fs /dev/mmcblk0p2

# Install openssh-server and configure
apt install -y openssh-server
update-rc.d -f ssh remove
update-rc.d -f ssh defaults

# Change ssh-host-key
rm /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server
service ssh restart

# Enable root login with ssh
mv /etc/ssh/sshd_config /etc/ssh/sshd_config.old
cp $(pwd)/configs/sshd_config /etc/ssh/sshd_config
chmod 644 /etc/ssh/sshd_config
service ssh restart
update-rc.d -f ssh enable 2 3 4 5

# Enable autologin
mv /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.old
cp $(pwd)/configs/lightdm.conf /etc/lightdm/lightdm.conf
chmod 644 /etc/lightdm/lightdm.conf

mv /etc/pam.d/lightdm-autologin /etc/pam.d/lightdm-autologin.old
cp $(pwd)/configs/lightdm-autologin /etc/pam.d/lightdm-autologin
chmod 644 /etc/pam.d/lightdm-autologin

# Update all and install kali-linux-full
apt update
apt upgrade -y
apt dist-upgrade -y
apt autoremove -y
apt install -y kali-linux-full

# Change password
if (whiptail --title "PASSWORD" --yesno "Want to change the password now?" --yes-button "Yes" --no-button "No" 10 60) then
    passwd
else
    exit
fi
