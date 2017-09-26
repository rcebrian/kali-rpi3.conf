# Kali Linux RPi first configs
----
Here is a simple a small package with scripts that do the first config of the Kali Linux distro for Raspberry Pi(in my case, the rpi3)
## The package contains:
    - autoconfig.sh:  this script resize the partition to use all the disk, install openssh-server and
    configure automatically, enable the autologin and you can change the password
    - install_raspi-config: install the last version of the raspi-config raspbian package (snubbegbg script)
    - install_vnc-server: install vnc-server and autoconfigure

## Installation:
git clone https://github.com/rcebs/kali-rpi3.conf.git

## Usage:
    sudo sh [script].sh
