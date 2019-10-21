nfs-formula:
  pkg.installed:
{% if grains.get('ha_sap_deployment_repo') %}
    - fromrepo: ha-factory
{% endif %}
    - retry:
        attempts: 3
        interval: 15
