core:
  '*':
    - podman
    - defaults
    - secrets
  '^.*saltmaster':
    - match: pcre
    - salt-master
