#!/bin/sh

# Update the box
apt-get -y update
apt-get -y upgrade

# install cloud-init
apt-get -y install cloud-init

#hostname will be managed by cloud-init, but the current value will not be removed
HOSTNAME=`hostname`
sed -i "/${HOSTNAME}/d" /etc/hosts

# Clean up
purge-old-kernels
apt-get -y remove dkms 
apt-get -y autoremove --purge
apt-get -y clean

# Remove temporary files
rm -rf /tmp/*

# Zero out free space
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY