#!/bin/bash

while ! nc -w 1 efk-es 9200 > /dev/null 2>&1; do
  echo "Kibana waiting TCP connection $ELASTICSEARCH_PORT_9200_TCP_ADDR:$ELASTICSEARCH_PORT_9200_TCP_PORT..."
  sleep 1
done

echo "Start Kibana"
kibana
