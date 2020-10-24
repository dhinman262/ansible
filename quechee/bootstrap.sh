#!/usr/bin/env bash

set -eu

ensure_ansible() {
    sudo DEBIAN_FRONTEND=noninteractive apt install ansible
}

ensure_inventory() {
    if [ ! -f inventory.yaml ]; then
        echo > inventory.yaml <<EOF
---
all:
  hosts:
    localhost:
      ansible_connection: local
EOF
    fi
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

ensure_python() {
    if [ ! -f /usr/bin/python3 ]; then
        sudo ln -s /usr/bin/python3 /usr/bin/python
    fi
    pip install diff-highlight
}

clone_repo() {
    cd ~
    if [ ! -d Resources ]; then
        mkdir Resources
    fi
    cd Resources
    if [ ! -d ansible ]; then
        git clone https://github.com/dhinman262/ansible.git
    fi
}
sudo apt update
ensure_ansible
ensure_python
ensure_inventory
ensure_git
clone_repo

