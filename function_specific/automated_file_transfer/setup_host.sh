#!/usr/bin/env bash

# TODO test for rsync, install if not already there
# TODO require openssh server? test for that?

# TODO maybe make this line idempotent?
printf "\nUseDNS yes" | sudo tee -a /etc/ssh/sshd_config
sudo service ssh restart

# Not clear that rrsync is worth it. Could restrict path, but:
# 1) Can I really not already?
# 2) Sometimes that's annoying.
# 3) rrsync is poorly documented.
#sudo gunzip /usr/share/doc/rsync/scripts/rrsync.gz
#sudo mv /usr/share/doc/rsync/scripts/rrsync /usr/local/bin/.
#sudo chmod +x /usr/local/bin/rrsync
