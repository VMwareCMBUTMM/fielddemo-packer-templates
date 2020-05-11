# Configure SSH
sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
sed -i "s/.*PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart sshd