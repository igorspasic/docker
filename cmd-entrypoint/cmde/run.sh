#!/usr/bin/env bash

docker build -t oblac .
docker run --rm --name pinger -d oblac
docker exec $(docker ps -q -f "name=pinger") ps
docker stop $(docker ps -q -f "name=pinger")