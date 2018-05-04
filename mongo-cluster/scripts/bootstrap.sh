#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

MONGO_DATA_1=($MONGO_DATA_1)
MONGO_DATA_2=($MONGO_DATA_2)
MONGO_CFG=($MONGO_CFG)

MONGO1=${MONGO_DATA_1[0]} \
	MONGO2=${MONGO_DATA_1[1]} \
	MONGO3=${MONGO_DATA_1[2]} \
	RS=${RS1} \
	$DIR/setup.sh

MONGO1=${MONGO_DATA_2[0]} \
	MONGO2=${MONGO_DATA_2[1]} \
	MONGO3=${MONGO_DATA_2[2]} \
	RS=${RS2} \
	$DIR/setup.sh

MONGO1=${MONGO_CFG[0]} \
	MONGO2=${MONGO_CFG[1]} \
	MONGO3=${MONGO_CFG[2]} \
	RS=${RS_CFG} \
	$DIR/setup-cfg.sh


## SHARD
echo '-----'
echo SHARD time now: `date +"%T" `

port=${PORT:-27017}
MONGO_SERVERS=(${MONGO_DATA_1[@]} ${MONGO_DATA_2[@]} ${MONGO_CFG[@]} $MONGOS)
source $DIR/_wait_mongo.sh

mongo --host ${MONGOS}:${port} <<EOF
   sh.addShard( "${RS1}/${MONGO_DATA_1[0]}:${port},${MONGO_DATA_1[1]}:${port},${MONGO_DATA_1[2]}:${port}" );
   sh.addShard( "${RS2}/${MONGO_DATA_2[0]}:${port},${MONGO_DATA_2[1]}:${port},${MONGO_DATA_2[2]}:${port}" );
   sh.status();
EOF
