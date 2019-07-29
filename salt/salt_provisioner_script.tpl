#!/bin/bash -xe

mv /tmp/salt /root || true

echo "Deployed by Terraform at $(date)" >> /etc/motd

# SCC Registration to install salt-minion

if grep -q 'role: iscsi_srv' /tmp/grains; then
  sh /root/salt/install-salt-minion.sh -r ${regcode}
elif [[ ! -e /usr/bin/salt-minion ]]; then
  sh /root/salt/install-salt-minion.sh -d -r ${regcode}
fi

mkdir -p /etc/salt;cp /tmp/grains /etc/salt || true

# Revert the ha_factory and ha_backport repo due to the priority of drbd-formula
echo -ne 'ha_factory_repo: "https://download.opensuse.org/repositories/network:/ha-clustering:/Backports/openSUSE_Leap_15.1/"\n' >> /etc/salt/grains
echo -ne 'additional_repos: {"factory": "https://download.opensuse.org/tumbleweed/repo/oss/",
                   "ha_backport": "https://download.opensuse.org/repositories/network:/ha-clustering:/Factory/openSUSE_Leap_15.1/"}\n' >> /etc/salt/grains
echo -ne 'additional_packages: ["tree", "less"]\n' >> /etc/salt/grains

# Server configuration
sh /root/salt/deployment.sh || exit 1

## Salt formulas execution
#if grep -q 'role: hana_node' /etc/salt/grains; then
#  sh /root/salt/formula.sh || exit 1
#fi
