#!/usr/bin/env bash

set -eu

ensure_ansible() {
    sudo DEBIAN_FRONTEND=noninteractive apt install ansible
}

ensure_inventory() {
    echo > inventory.yaml <<EOF
---
all:
  hosts:
    localhost:
      ansible_connection: local
EOF
    sudo ansible \
        --inventory='localhost,' \
        --connection='local' \
        --module-name='copy' \
        --args='src=inventory.yaml dest=/etc/ansible/hosts' \
        localhost
}

ensure_git() {
    sudo  DEBIAN_FRONTEND=noninteractive apt-get install git
}

clone_repo() {
    cd ~
    mkdir Resources
    cd Resources
    git clone https://github.com/dhinman262/ansible.git
}
sudo apt update
ensure_ansible
ensure_inventory
ensure_git
clone_repo

