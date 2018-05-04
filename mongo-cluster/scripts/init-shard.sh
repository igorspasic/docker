#!/bin/bash

echo INIT_SHARD time now: `date +"%T" `

port=${PORT:-27017}
MONGO_SERVERS=(${MONGO_DATA_1[@]} ${MONGO_DATA_1[@]} $MONGOS)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/_wait_mongo.sh

data1=""
for M in "${MONGO_DATA_1[@]}"
do
	data1="$data1,$M:$port"
done
data2=""
for M in "${MONGO_DATA_2[@]}"
do
	data2="$data2,$M:$port"
done


mongo --host ${MONGOS}:${port} <<EOF
   sh.addShard( "${RS1}/${data1}" );
   sh.addShard( "${RS2}/${data2}" );
   sh.status();
EOF
