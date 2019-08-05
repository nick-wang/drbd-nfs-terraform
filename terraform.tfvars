#image="/vmdisk/jenkins-cluster/test-dummy-for-terraform/sles12sp1-node1.qcow2"
#image="/vmdisk/jenkins-cluster/test-dummy-for-terraform/SUSE-HA-SLE15-sp1-rc1-salt-node1.qcow2"
image="/var/lib/libvirt/images/backup-suma/sles15"

storage_pool="ssd"

hcount=3

#iprange=["192.168.10.10/24", "192.168.20.10/24"]
iprange=["192.168.30.10/24"]

shared_img=false

drbdnfs="cluster"

ha_sap_deployment_repo="https://download.opensuse.org/repositories/network:/ha-clustering:/Backports/openSUSE_Leap_15.0/"
additional_packages=["tree", "less", "man"]

# Optional SUSE Customer Center Registration parameters
reg_code = "<<REG_CODE>>"
reg_email = "<<your email>>"
reg_additional_modules = {
    "sle-module-containers/15/x86_64" = ""
    "sle-ha/15/x86_64" = "<<REG_CODE_HA>>"
}
