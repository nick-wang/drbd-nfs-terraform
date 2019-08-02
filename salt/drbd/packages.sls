{% if grains['role'] == 'drbd' %}
drbd-kmp-default:
  pkg.installed:
    - retry:
        attempts: 3
        interval: 15

drbd-formula:
  pkg.installed:
{% if grains['ha_sap_deployment_repo'] %}
    - fromrepo: ha-factory
{% endif %}
    - retry:
        attempts: 3
        interval: 15

habootstrap-formula:
  pkg.installed:
{% if grains['ha_sap_deployment_repo'] %}
    - fromrepo: ha-factory
{% endif %}
    - retry:
        attempts: 3
        interval: 15
{% endif %}
