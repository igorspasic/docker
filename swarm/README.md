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

	ansible-playbook /vagrant/ansible/swarm.yml -i /vagrant/ansible/hosts/prod

For **swarm mode**:

	ansible-playbook /vagrant/ansible/swarm-mode.yml -i /vagrant/ansible/hosts/prod

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

Use docker in `swarm mode`:

	docker info

### Docker system service

Service log: `sudo cat /var/log/upstart/docker.log`

Start service: `sudo start docker`


### Swarm mode example

	$ docker network create mynet -d overlay
	$ docker service create --name redis --network mynet redis:3
	$ docker service ls
	ID            NAME   REPLICAS  IMAGE    COMMAND
	c9jen63am2gi  redis  1/1       redis:3

Scale:

	$ docker service update --replicas 5 redis
	$ docker service ps redis

	ID                         NAME     IMAGE    NODE          DESIRED STATE  CURRENT STATE           ERROR
	5lx1bob284bpqentz3xi3zgrf  redis.1  redis:3  swarm-master  Running        Running 5 minutes ago
	07bt3m66roiaqm8iz4qt77mj1  redis.2  redis:3  swarm-node-2  Running        Running 2 seconds ago
	2bd3iws4vm0g09zseotf91ocy  redis.3  redis:3  swarm-node-1  Running        Running 6 seconds ago
	7pfvklqlg0e62ulfaboce0f5z  redis.4  redis:3  swarm-node-1  Running        Running 6 seconds ago
	5pgcknsowt24dtfgioch3h5de  redis.5  redis:3  swarm-master  Running        Running 32 seconds ago


## Issues

+ Updating APT fails randomly: [workaround](https://groups.google.com/forum/#!topic/ansible-project/4-CV1SszOAY).
  [reported issue](https://github.com/ansible/ansible-modules-core/issues/2951).

```
	sudo rm -vf /var/lib/apt/lists/*
	sudo apt-get clean
	sudo apt-get update
	sudo apt-get upgrade
```