podman-packages:
  pkg.installed:
    - pkgs:
        - podman
        - podman-compose
        - podman-toolbox

/home/hile/.ssh/podman:
   file.managed:
     - user: hile
     - mode: 0600
     - contents_pillar: podman_ssh_key

/home/hile/.bashrc:
   file.append:
     - text: |
         alias podman='ssh -i $HOME/.ssh/podman podman@localhost'

podman:
  user.present:
    - shell: /bin/bash
    - home: /home/podman

sshkeys:
  ssh_auth.present:
    - user: podman
    - enc: ed25519
    - names:
        - AAAAC3NzaC1lZDI1NTE5AAAAIMNociB5nkVm1X5kZgxtvxg5T5HDfsxw6XlDbQBHuX5/
