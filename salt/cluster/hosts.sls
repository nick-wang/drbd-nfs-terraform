{% for id in range(grains['host_nodes']) %}
{{ grains['hostname'][:-1] }}{{ id + 1 }}:
  host.present:
    - ip: {{ grains['network_address_base'] }}{{ id }}
    - names:
      - {{ grains['hostname'][:-1] }}{{ id + 1 }}
{% endfor %}
