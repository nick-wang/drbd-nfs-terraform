drbd-kmp-default:
  pkg.installed:
    - retry:
        attempts: 3
        interval: 15

drbd-formula:
  pkg.installed:
{% if grains.get('ha_sap_deployment_repo') %}
    - fromrepo: ha-factory
{% endif %}
    - retry:
        attempts: 3
        interval: 15

parted_package:
  pkg.installed:
    - name: parted
    - retry:
        attempts: 3
        interval: 15
