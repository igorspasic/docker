#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo ">>> Bootstrap Vagrant..."

rm -r /var/cache/apt /var/lib/apt/lists
apt-get update -y
