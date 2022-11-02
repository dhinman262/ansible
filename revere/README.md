# Provisioning for my new desktop machine revere

To get the process started, run the bootstrap script:

```
wget -qO - \
    https://github.com/dhinman262/ansible/raw/revere/revere/bootstrap.sh \
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
# We seem to need to get github in the known_hosts file
# Let's capture the file before and after we do a log, and save away the key for github


cd /opt/home/dhinman/Resources/ansible
git checkout revere
git pull origin revere

cd revere
bash ./cloneAndLink.sh
```

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
