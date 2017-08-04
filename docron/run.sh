#!/usr/bin/env bash

docker image rm oblac/docron
docker build -t oblac/docron .
docker run -it oblac/docron
