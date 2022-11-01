# Provisioning for my new desktop machine revere

To get the process started, run the bootstrap script:

```
bash <(wget -qO - https://github.com/dhinman262/ansible/raw/revere/revere/bootstrap.sh)
```

This will:

- install Ansible

- install Git

- make sure Python 3 is present

- create an Ansible inventory

- generate an ssh id (if none is present)

- check out the ansible repo (using https)

## Testing via Vagrant

So:

```
vagrant up
vagrant ssh

On the box:


cd /vagrant
./bootstrap.sh
ansible-playbook 
```
