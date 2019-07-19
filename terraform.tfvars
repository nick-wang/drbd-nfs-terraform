#image="/vmdisk/jenkins-cluster/test-dummy-for-terraform/sles12sp1-node1.qcow2"
#image="/vmdisk/jenkins-cluster/test-dummy-for-terraform/SUSE-HA-SLE15-sp1-rc1-salt-node1.qcow2"
image="/var/lib/libvirt/images/backup-suma/sles15sp1"

storage_pool="ssd"

hcount=3

#iprange=["192.168.10.10/24", "192.168.20.10/24"]
iprange=["192.168.10.10/24"]

shared_img=false
