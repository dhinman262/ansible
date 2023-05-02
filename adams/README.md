# Provisioning adams after a wipe

First, I have to have Linux Mint 21 installed and a working network connection. The bootstrap will setup a new ssh key.

I installed openssh-server fro remote access.

Then, run the bootstrap script:

```
wget -qO - \
    https://github.com/dhinman262/ansible/raw/master/adams/bootstrap.sh \
    > dlb.sh
bash ./dlb.sh
```

This will:

- install Ansible

- install Git

- make sure Python 3 is present

- create an Ansible inventory

- generate an ssh id (if none is present)

- check out the ansible repo (using https)

## Next: clone and link

```
# We seem to need to get github in the known_hosts file; let's get it now

cd /opt/home/dhinman/Resources/ansible
git fetch pgh
git checkout --track pgh/revere

cd revere
bash ./cloneAndLink.sh
```

## Next: install everything using ansible
```
sudo ansible-playbook -vvvv revere-playbook.yaml > ansible.log
```

## Next: Do the work afterwards

- Update all the packages

- 
## Testing via Vagrant (not sure this actually works)

So:

```
vagrant up
vagrant ssh

On the box:


cd /vagrant
./bootstrap.sh
ansible-playbook 
```
