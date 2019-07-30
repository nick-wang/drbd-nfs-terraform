{% if grains['role'] == 'drbd' %}
drbd-kmp-default:
  pkg.installed:
    - fromrepo: ha-factory
    - retry:
        attempts: 3
        interval: 15

drbd-formula:
  pkg.installed:
    - fromrepo: ha_backport_repo_default
    - retry:
        attempts: 3
        interval: 15

habootstrap-formula:
  pkg.installed:
    - fromrepo: ha_backport_repo_default
    - retry:
        attempts: 3
        interval: 15
{% endif %}
