#!/bin/sh

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

# Clean Machine ID
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id


# Stop services for cleanup
service rsyslog stop

# Clear audit logs
if [ -f /var/log/wtmp ]; then
    truncate -s0 /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    truncate -s0 /var/log/lastlog
fi