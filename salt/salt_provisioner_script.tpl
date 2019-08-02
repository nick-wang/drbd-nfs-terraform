#!/bin/bash -xe

mv /tmp/salt /root || true

echo "Deployed by Terraform at $(date)" >> /etc/motd

# SCC Registration to install salt-minion
if grep -q 'role: drbd' /tmp/grains; then
  sh /root/salt/scripts/install-salt-minion.sh -r ${regcode}
elif [[ ! -e /usr/bin/salt-minion ]]; then
  sh /root/salt/scripts/install-salt-minion.sh -d -r ${regcode}
fi

mkdir -p /etc/salt;cp /tmp/grains /etc/salt || true

# Server configuration
sh /root/salt/scripts/deployment.sh || exit 1


# Need to guarantee all nodes are online
## Salt formulas execution
#if grep -q 'role: drbd' /etc/salt/grains; then
#  sh /root/salt/scripts/formula.sh || exit 1
#fi
