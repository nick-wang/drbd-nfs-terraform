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

# Need to adjust with nfs-formula install location
# This only works when `/root/salt` available in file_roots
if grep -q 'role: drbd' /etc/salt/grains; then
  if grep -q 'drbdnfs: raw' /etc/salt/grains; then
    mv /root/salt/nfs/ondrbd.sls /root/salt/nfs/ondrbd.sls.old
    cp -rf /root/salt/misc/nfs-formula-states/ondrbd.sls /root/salt/nfs/ondrbd.sls
  fi
fi

# Need to guarantee all nodes are online
# Need to modify the drbd-formula since changes not to project yet.
## Salt formulas execution
#if grep -q 'role: drbd' /etc/salt/grains; then
#  sh /root/salt/scripts/formula.sh || exit 1
#fi
