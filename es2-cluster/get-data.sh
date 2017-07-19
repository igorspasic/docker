#!/usr/bin/env bash

curl -XGET 'localhost:9200/shakespeare/_search?q=line_number:1.7.3&pretty'
