
echo "Waiting Mongo servers for startup..."

for MONGO in "${MONGO_SERVERS[@]}"
do
	echo "Trying: ${MONGO}..."
	until mongo --host ${MONGO}:${port} --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 2)' &>/dev/null; do
	  printf '.'
	  sleep 1
	done

	echo
	echo "${MONGO} is up"
done
