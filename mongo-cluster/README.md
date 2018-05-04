# MongoDB cluster on Docker Swarm

This MongoDB stack is a set of `Mongos`, `Config` and `Data` replica sets onto Docker Swarm, forming a high-available MongoDB cluster capable of surviving multiple nodes failure without service interruption. The Docker stack is composed of the following:

+ `Data` shards of 2 replica sets (3 instances each),
+ `Config` replica set (3 replica instances),
+ Two `Mongos` routers,
+ single, one-time `bootstrap` service.

It's 11 running services in total.

## Nodes

Each instance of this set should be assigned to the single node. For that purpose we can use node labels. By default, however, labels are commented out.

## Deployment

Just run:

```bash
up.sh
```

### Networking

The `Config` and `Data` replica sets are isolated from the rest of the swarm in the `mongo` overlay network. The routers, `Mongos1` and `Mongos2` are connected to the `mongo` network and to the `mongos` network. You should attach application containers to the `mongos` network in order to communicate with the MongoDB Cluster.

### Persistent storage

At first run, each `Data` and `Config` node will be provisioned with a named Docker volumes.

### Bootstrapping

After the stack has been deploy the `mongo-bootstrap` service will do the following:

+ waits for the `Data` services to be online
+ joins the `Data` nodes into a replica sets (`datars1` and `datars2`)
+ waits for the `Config` services to be online
+ joins the `Config` nodes into a replica set (`cfgrs`)
+ waits for the `Mongos1` service to be online
+ registers the `Data` replica sets shard to the mongos instances

## Connect

To use the cluster, attached to the `mongos` network:

```bash
$ docker run --network mongos -it mongo mongo mongos1:27017
```

The Mongo clients should connect to all Mongos nodes that are running on the `mongos` overlay network. Here is an example:

```
"mongodb://mongos1:27017,mongos2:27017/"
```

## High availability

A MongoDB cluster can survive node failures and will start an automatic failover if:

+ the primary `Data` node goes down
+ the primary `Config` node goes down
+ one of the `Mongos` nodes goes down

When the primary `Data` or `Config` node goes down, the `Mongos` instances will detect the new primary node and will reroute all the traffic to it. If a `Mongos` node goes down and your applications are configured to use both `Mongos` nodes, the Mongo driver will switch to the online `Mongos` instance. When you recover a failed `Data` or `Config` node, this node will rejoin the replica set and resync if the oplog size allows it.
