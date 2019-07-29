{% if grains['role'] == 'drbd' %}
drbd-formula:
  pkg.installed:
    - fromrepo: ha-factory
    - retry:
        attempts: 3
        interval: 15

habootstrap-formula:
  pkg.installed:
    - fromrepo: ha-factory
    - retry:
        attempts: 3
        interval: 15
{% endif %}
