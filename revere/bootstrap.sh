#!/usr/bin/env bash

set -eu
RESOURCEDIR=/opt/home/dhinman/Resources

ensure_ansible() {
    sudo DEBIAN_FRONTEND=noninteractive apt install ansible
}

ensure_inventory() {
    if [ ! -d /etc/ansible ]; then
        sudo mkdir -p /etc/ansible
    fi
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
    #if [ ! -f /usr/bin/python3 ]; then
    #    sudo ln -s /usr/bin/python3 /usr/bin/python
    #fi
    if [ ! -e /usr/bin/python3 ]; then
	sudo  DEBIAN_FRONTEND=noninteractive apt install python3
    fi
	     
    if [ ! -e /usr/bin/python ]; then
	    sudo DEBIAN_FRONTEND=noninteractive apt install python-is-python3
    fi
    sudo apt-get install python3-pip
    pip3 install diff-highlight
}

gen_key() {
    if [ ! -e ~/.ssh/id_rsa ]; then
	mkdir -p ~/.ssh
	chmod 0700 ~/.ssh
	ssh-keygen -t rsa -b 4096
    fi
}


ensure_resourcedir() {
    if [ ! -d ${RESOURCEDIR} ]; then
        # If we can't write /opt, we need to fix it
        if [ ! -w /opt ]; then
            sudo  DEBIAN_FRONTEND=noninteractive chmod a+w /opt
        fi
        mkdir -p ${RESOURCEDIR}
    fi
}

clone_repo() {
    cd ${RESOURCEDIR}
    if [ ! -d ansible ]; then
        git clone https://github.com/dhinman262/ansible.git
	(cd ansible; git remote add pgh git@github.com:dhinman262/ansible.git )
    fi
}
sudo apt update
ensure_ansible
ensure_python
ensure_inventory
ensure_git
gen_key
ensure_resourcedir
clone_repo

