#!/usr/bin/env bash

curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/shakespeare/_bulk?pretty' --data-binary @dataset/shakespeare.json

