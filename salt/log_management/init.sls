install_gpg_key:
  file.managed:
    - name: /usr/share/keyrings/elasticsearch-keyring.gpg
    - contents_pillar: es_gpg_key

temp_file:
  file.remove:
    - name: /tmp/elasticsearch-keyring.gpg

install_monitoring_tools:
  pkg.installed:
    - pkgs: 
        - filebeat
        - metricbeat

install_default_filebeat_configs:
  file.managed:
    - source: salt://log_management/configs/filebeat.yml
    - name: /etc/filebeat/filebeat.yml
    - template: jinja

install_default_metricbeat_configs:
  file.managed:
    - source: salt://log_management/configs/metricbeat.yml
    - name: /etc/metricbeat/metricbeat.yml
    - template: jinja

customize_system_module:
  file.managed:
    - name: /etc/filebeat/modules.d/system.yml
    - source: salt://log_management/configs/modules.d/filebeat/system.yml

metricbeat:
  service.running:
    - enable: True
    - reload: True

filebeat:
  service.running:
    - enable: True
    - reload: True