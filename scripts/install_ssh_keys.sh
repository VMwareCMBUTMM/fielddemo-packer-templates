# Move the SSH key to Authorized Keys and ensure permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat /tmp/id_autotmm.pub > ~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys
# rm ~/id_autotmm.pub