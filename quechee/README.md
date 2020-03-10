# Provisioning for my new Chromebook

To get the process started, run the bootstrap script:

```
bash <(wget -qO - https://github.com/ztsmith/ansible-chromebook-desktop/raw/master/run.sh)
```

## Testing via Vagrant

So:

```
vagrant up
vagrant ssh

On the box:


cd /vagrant
bootstrap.sh
```
