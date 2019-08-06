habootstrap-formula:
  pkg.installed:
{% if grains.get('ha_sap_deployment_repo') %}
    - fromrepo: ha-factory
{% endif %}
    - retry:
        attempts: 3
        interval: 15

install_cluster_packages_prepare:
  pkg.installed:
    - pkgs:
      - pacemaker
      - crmsh
      - ha-cluster-bootstrap
      - hawk2
