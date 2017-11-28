## Docker [ZooKeeper] image for the [Confluent Open Source Platform] using [Oracle JDK] ##

### Supported tags and respective Dockerfile links: ###

* ```3.2.2``` _\([3.2.2/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-zookeeper:3.2.2.svg)](https://microbadger.com/images/mbe1224/confluent-zookeeper:3.2.2 "")
* ```3.3.0``` _\([3.3.0/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-zookeeper:3.3.0.svg)](https://microbadger.com/images/mbe1224/confluent-zookeeper:3.3.0 "")
* ```3.3.1```, ```latest``` _\([3.3.1/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-zookeeper:3.3.1.svg)](https://microbadger.com/images/mbe1224/confluent-zookeeper:3.3.1 "")

*All tag names follow the naming convention of the [Confluent Open Source Platform]*

### Summary: ###

- Debian "slim" image variant
- Oracle JDK 8u152 addded, without MissionControl, VisualVM, JavaFX, ReadMe files, source archives, etc.
- Oracle Java Cryptography Extension added
- Python 2.7.9-1 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME environment variable set up
- Utility scripts added:
    - [Confluent utility belt script ('cub')] - a Python CLI for a Confluent tool called [docker-utils]
    - [Docker utility belt script ('dub')]
- [Apache ZooKeeper] added:
    - version 3.4.9 in ```3.2.2```
    - version 3.4.10 in ```3.3.0```, ```3.3.1``` and ```latest``` 

### Details: ### 

This image was created with the sole purpose of offering the [Confluent Open Source Platform] running on top of [Oracle JDK].
Therefore, it follows the same structure as the one from the original [repository]. More precisely:
- tag ```3.2.2``` follows branch [3.2.x], and 
- tags ```3.3.0```, ```3.3.1``` and```latest``` follow branch [3.3.x]

Apart of the base image ([mbe1224/confluent-base]), it has [Apache ZooKeeper] added on top of it, installed using the following Confluent Debian package:
- ```confluent-kafka-2.11```

### Usage: ###

Build the image
```shell
docker build -t mbe1224/confluent-zookeeper ./3.3.1/
```

Run the container
```shell
docker run -d \
    --net=host \
    --name=zookeeper \
    -e ZOOKEEPER_CLIENT_PORT=32181 \
    mbe1224/confluent-zookeeper
```

### Configuration: ###

One can configure a ZooKeeper instance using environment variables. All [configuration options from the official documentation] can be used as long as the following naming rules are followed:
- upper caps
- "." replaced with "\_"
- snake case instead of pascal case
- "ZOOKEEPER\_" prefix

For example, in order to limit the number of concurrent connections a single client may make to a single member of the ZooKeeper ensemble, one has to modifiy the "maxClientCnxns" property, which is translated in the "ZOOKEEPER\_MAX\_CLIENT\_CNXNS" environment variable.

The following default values are used:

| # | Name | Default value | Meaning |
|---|---|---|---|
| 1 | ZOOKEEPER\_DATA\_DIR | /var/lib/zookeeper/data | The location where ZooKeeper will store the in-memory database snapshots and, unless specified otherwise, the transaction log of updates to the database |
| 2 | ZOOKEEPER\_DATA\_LOG\_DIR | /var/lib/zookeeper/log | This allows a dedicated log device to be used, and helps avoid competition between logging and snaphots |
| 3 | ZOOKEEPER\_INIT\_LIMIT | 10 | Timeouts ZooKeeper uses to limit the length of time the ZooKeeper servers in quorum have to connect to a leader |
| 4 | ZOOKEEPER\_LOG4J\_ROOT\_LOGLEVEL | INFO | - |
| 5 | ZOOKEEPER\_SYNC\_LIMIT | 5 | Timeouts ZooKeeper to limit how far out of date a server can be from a leader |

In addition to these, the following environment variables are added for replicated scenarios:

| # | Name | Meaning |
|---|---|---|
| 1 | ZOOKEEPER\_GROUPS | Semicolon separated list of indexed group identifiers used for forming hierarchical quorums |
| 2 | ZOOKEEPER\_SERVER\_ID | Node identifier |
| 3 | ZOOKEEPER\_SERVERS | Semicolon separated list of *host:port1:port2* where *port1* is used for follower connections, if the current node is the leader and *port2* is used for server connections during the leader election phase |
| 4 | ZOOKEEPER\_WEIGHTS | Semicolon separated list of indexed weights used for forming quorums |

Furthrmore, one can tweak the JVM heap size using the JVM\_HEAP\_SIZE environment variable, that has a default value of 2GB.

For more information, check the [Apache ZooKeeper's Official Documentation].

#### Kubernetes: ####

For Kubernetes deployments using StatefulSets (or other replication objects), ZOOKEEPER\_SERVER\_ID can't be set up in advance. Therefore, one needs to set the IS\_KUBERNETES environemnt variable to a non-null value. In this scenario, ZooKeeper's ID (myid) will be generated using the value of the HOSTNAME environment variable.

Nevertheless, if one uses Pods, than the usual setup can be used and the IS\_KUBERNETES environemnt variable must be ignored.


### Dual licensed under: ###

* [MIT License]
* [Oracle Binary Code License Agreement]

   [docker-utils]: <https://github.com/confluentinc/cp-docker-images/tree/master/java>
   [Confluent Open Source Platform]: <https://www.confluent.io/product/confluent-open-source/>
   [Apache ZooKeeper]: <https://zookeeper.apache.org/>   
   [Apache ZooKeeper's Official Documentation]: <http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html>
   [configuration options from the official documentation]: <http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration>
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [ZooKeeper]: <https://zookeeper.apache.org/>   
   [3.2.2/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-confluent-zookeeper/blob/master/3.2.2/Dockerfile>
   [3.3.0/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-confluent-zookeeper/blob/master/3.3.0/Dockerfile>
   [3.3.1/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-confluent-zookeeper/blob/master/3.3.1/Dockerfile>
   [Confluent utility belt script ('cub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/cub>
   [Docker utility belt script ('dub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/dub>  
   [repository]: <https://github.com/confluentinc/cp-docker-images>
   [3.2.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.2.x>
   [3.3.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.3.x>   
   [mbe1224/confluent-base]: <https://hub.docker.com/r/mbe1224/confluent-base/>
   [MIT License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/docker-confluent-zookeeper/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/docker-confluent-zookeeper/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>