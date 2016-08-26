# Docker Swarm

+ Vagrant
+ Ansible
+ Consul
+ EFK
+ Promethus & cAdvisors
+ Swarm

## TODO

+ [ ] Prometheus targets
+ [ ] Remove `wnodes` dependecy for Prometheus targets
+ [ ] Make Kibana work (index)
+ [ ] Use [Dynamic Inventory](http://docs.ansible.com/ansible/intro_dynamic_inventory.html)

## Prerequisites

Optional, but recommended:

	vagrant plugin install vagrant-cachier
	vagrant plugin install vagrant-hostsupdater

Required for Ubuntu 16.04 (not used, skip):

	vagrant plugin install vagrant-vbguest

## VMs

Create the VMs:

	vagrant up swarm-master /swarm-node-[1-2]/

If `vagrant-hostsupdater` is used then administrative access is required.


## Infrastructure

Now that the VMs are created, let's go inside the `swarm-master`

	vagrant ssh swarm-master

	ansible-playbook /vagrant/ansible/all.yml -i /vagrant/ansible/hosts/prod

**First time only:** log out and log in to use `docker` in command line.

### Reset everything

	vagrant destroy -f

## Usage

Once when everything is up:

+ [Consul Status](http://swarm-master:8500/v1/health/service/consul?pretty)
+ [Consul UI](http://swarm-master:8500/ui/)
+ [Prometheus](http://swarm-master:9090)
+ [Kibana](http://swarm-master:5601)

Use docker on `swarm-master` (local):

	docker info
	sudo docker -H unix:///var/run/docker.sock info

Use docker on `swarm-master` (swarm):

	docker -H :4000 info
	docker -H :4000 ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

Use docker on `swarm-node-1`:

	docker -H :2375 info

### Docker service

Service log: `sudo cat /var/log/upstart/docker.log`

Start service: `sudo start docker`

## Issues

+ Updating APT fails randomly: [workaround](https://groups.google.com/forum/#!topic/ansible-project/4-CV1SszOAY).
  [reported issue](https://github.com/ansible/ansible-modules-core/issues/2951).

```
	sudo rm -vf /var/lib/apt/lists/*
	sudo apt-get clean
	sudo apt-get update
	sudo apt-get upgrade
```