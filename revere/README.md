# Provisioning for my new desktop machine revere

To get the process started, run the bootstrap script:

```
bash <(wget -qO - https://github.com/dhinman262/ansible/raw/master/revere/bootstrap.sh)
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
