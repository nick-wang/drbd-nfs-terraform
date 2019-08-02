cluster:
  name: 'hacluster'
  init: 'Fdrbdopensuse150-testnode-1'
  interface: 'eth0'
  join_timer: 20
  watchdog:
    module: softdog
    device: /dev/watchdog
  sbd:
    device: '/dev/vdc'
  ntp: pool.ntp.org
  install_packages: true
  sshkeys:
    overwrite: true
    password: linux
  configure:
    method: 'update'
    template:
      source: /tmp/drbd.j2
      parameters:
        virtual_ip: 192.168.20.200
        virtual_ip_mask: 24
        platform: libvirt
        prefer_takeover: true
        auto_register: false
