include:
{% if grains['ha_sap_deployment_repo'] %}
  - pre_installation.ha_repos
{% endif %}
  - pre_installation.minion_configuration
