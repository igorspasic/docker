# Docker swarm

+ Vagrant
+ Ansible
+ Consul
+ Swarm

## TODO

+ [ ] Use [Dynamic Inventory](http://docs.ansible.com/ansible/intro_dynamic_inventory.html)
+ [ ] Remove some variables from hosts

## Prerequisites

	vagrant plugin install vagrant-cachier

## VMs

Create the VMs:

	vagrant up swarm-master /swarm-node-[1-2]/

## Infrastructure

Now that the VMs are created, let's go inside the `swarm-master`

	vagrant up
	vagrant ssh swarm-master

	ansible-playbook /vagrant/ansible/all.yml -i /vagrant/ansible/hosts/prod

### Reset everything

	vagrant destroy -f

## Issues

+ Updating APT fails randomly: [workaround](https://groups.google.com/forum/#!topic/ansible-project/4-CV1SszOAY).
  [reported issue](https://github.com/ansible/ansible-modules-core/issues/2951).

```
	sudo rm -vf /var/lib/apt/lists/*
	sudo apt-get clean
	sudo apt-get update
	sudo apt-get upgrade
```