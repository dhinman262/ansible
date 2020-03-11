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

sudo apt update
ensure_ansible
ensure_inventory
