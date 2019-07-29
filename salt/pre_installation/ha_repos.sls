ha-factory-repo:
  pkgrepo.managed:
    - name: ha-factory
    - baseurl: {{ grains['ha_factory_repo'] }}
    - gpgautoimport: True
    - priority: 110
    - gpgcheck: 0
    - retry:
        attempts: 3
        interval: 15
