#!/bin/bash

echo '-----'
echo SETUP $RS time now: `date +"%T" `

port=${PORT:-27017}
MONGO_SERVERS=($MONGO1 $MONGO2 $MONGO3)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/_wait_mongo.sh

mongo --host ${MONGO1}:${port} <<EOF
   var cfg = {
        "_id": "${RS}",
        "members": [
            {
                "_id": 0,
                "host": "${MONGO1}:${port}"
            },
            {
                "_id": 1,
                "host": "${MONGO2}:${port}"
            },
            {
                "_id": 2,
                "host": "${MONGO3}:${port}"
            }
        ]
    };
    rs.initiate(cfg, { force: true });
    rs.reconfig(cfg, { force: true });
EOF
