#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo ">>> Installing Ansible..."

apt-get -y update
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible


echo ">>> Configuring Ansible..."

cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg


echo ">>> Ansible OK"