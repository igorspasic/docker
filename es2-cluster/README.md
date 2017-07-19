# Elastic Search 2.2 cluster

The cluster consist of the following components:


## Usage

Run the system with:

	./run.sh

After system is up and running, you have the following overviews:

+ [Cluster overview](http://localhost:9200/_plugin/hq/#cluster)
+ [Head overview](http://localhost:9200/_plugin/head)
+ [Kibana](http://localhost:5601)

## Dataset

After system is up, import the data:

	./insert-data.sh

This import creates `shakespeare` index.
