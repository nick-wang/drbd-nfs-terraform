# Change according to the output of ../module/base
base_configuration = {
  prefix = "sle15sp1"
  pool = "ssd"
  domain = "nwang.local"
  #image_id = "/ssddummy/libvirtimages/sle15sp1-baseimage"
  image_name = "sle15sp1-baseimage"
  iprange="192.168.10.10/24,192.168.20.10/24"
  shared_img=0
  timezone = "Asia/Beijing"
  public_key_location="~/.ssh/id_rsa.pub"

  # Need to change the network_id after base create, use the real one.
  network_id = "dd5c3664-fb6a-4759-b2f8-ee7d90fea559"
}

name="nwang"
hcount=2
xmlfile="shareable.xsl"
salt_path="../../salt"

# Optional SUSE Customer Center Registration parameters
reg_code = "<<REG_CODE>>"
reg_email = "<<your email>>"
reg_additional_modules = {
    "sle-module-containers/15.1/x86_64" = ""
    "sle-ha/15.1/x86_64" = "<<REG_CODE_HA>>"
}
