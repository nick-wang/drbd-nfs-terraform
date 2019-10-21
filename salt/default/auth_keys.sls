{% if grains['authorized_keys'] %}
authorized_keys:
  file.append:
    - name: /root/.ssh/authorized_keys
    - text:
{% for key in grains.get('authorized_keys') %}
      - {{ key }}
{% endfor %}
    - makedirs: True
{% endif %}
