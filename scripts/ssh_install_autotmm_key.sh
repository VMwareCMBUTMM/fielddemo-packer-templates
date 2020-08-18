# Move the SSH key to Authorized Keys and ensure permissions
mkdir -p /home/autotmm/.ssh
chmod 700 /home/autotmm/.ssh
cat /tmp/id_rsa.pub > /home/autotmm/.ssh/authorized_keys
chmod 644 /home/autotmm/.ssh/authorized_keys
chown -R autotmm /home/autotmm/.ssh
rm -rf /tmp/id_rsa.pub