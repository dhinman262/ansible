# Provisioning for my new Chromebook

To get the process started, run the bootstrap script:

```
bash <(wget -qO - https://github.com/dhinman262/ansible/raw/master/quechee/bootstrap.sh)
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
