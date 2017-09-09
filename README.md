# [Confluent Open Source Platform](https://www.confluent.io/product/confluent-open-source/) [Apache ZooKeeper] Docker image using [Oracle JDK] #

### Supported tags and respective Dockerfile links: ###

* ```jesse-slim-8u144-2.11.11-3.2.2``` _\([jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-zookeeper:jesse-slim-8u144-2.11.11-3.2.2.svg)](https://microbadger.com/images/mbe1224/confluent-osp-zookeeper:jesse-slim-8u144-2.11.11-3.2.2)
* ```jesse-slim-8u144-2.11.11-3.3.0```, ```latest``` _\([jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-zookeeper:jesse-slim-8u144-2.11.11-3.3.0.svg)](https://microbadger.com/images/mbe1224/confluent-osp-zookeeper:jesse-slim-8u144-2.11.11-3.3.0)

#### All tag names follow the naming convention: ####

```debian_image_tag``` + '-' + ```java_version``` + '-' + ```scala_version``` + '-' + ```confluent_platform_version```

### About: ### 

#### Summary: ####

- Debian "slim" image variant
- Oracle Java SE Development Kit (JDK) 8u144 addded, without MissionControl, VisualVM, JavaFX and JRE
- Oracle Java Cryptography Extension added
- Scala 2.11.11 added
- Python 2.7.9-1 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME and SCALA\_HOME environment variables set up
- Utility scripts added:
    - [Confluent utility belt script ('cub')] - a Python CLI for a Confluent tool called [docker-utils]
    - [Docker utility belt script ('dub')]
- [Apache ZooKeeper] added

#### More details: ####

This image was created with the sole purpose of offering the [Confluent Open Source Platform] running on top of [Oracle JDK].
Therefore, it follows the same structure as the one from the original [repository]. More precisely:
- tag ```jesse-slim-8u144-2.11.11-3.2.2``` follows branch [3.2.x], and 
- tags ```jesse-slim-8u144-2.11.11-3.3.0``` and```latest``` follow branch [3.3.x]


Apart of the base image ([confluent-osp-base]), it has [Apache ZooKeeper] added on top of it, installed using the following Confluent Debian package:
- ```confluent-kafka-2.11```

### Usage: ###

Build the image
```shell
docker build -t mbe1224/confluent-osp-zookeeper .
```

Run the container
```shell
docker run -d \
    --net=host \
    --name=zookeeper \
    -e ZOOKEEPER_CLIENT_PORT=32181 \
    mbe1224/confluent-osp-zookeeper
```

### Environment variables: ###

One can use the following environment variables for configuring the ZooKeeper node:

| # | Name | Default value | Meaning | Comments |
|---|---|---|---|---|
| 1 | KAFKA\_JMX\_OPTS | - | JMX options used for monitoring | KAFKA\_OPTS should contain 'com.sun.management.jmxremote.rmi.port' property |
| 2 | ZOOKEEPER\_CLIENT\_PORT | 2181  | The port to listen for client connections | - |
| 3 | ZOOKEEPER\_GROUPS | - | Semicolon separated list of indexed group identifiers used for forming hierarchical quorums | Optional, used in ZooKeeper replicated scenarios |
| 4 | ZOOKEEPER\_INIT\_LIMIT | 10 | Timeouts ZooKeeper uses to limit the length of time the ZooKeeper servers in quorum have to connect to a leader | - |
| 5 | ZOOKEEPER\_LOG4J\_LOGGERS | - | - | - |
| 6 | ZOOKEEPER\_LOG4J\_ROOT\_LOGLEVEL | INFO | - | - |
| 7 | ZOOKEEPER\_SERVER\_ID | - | Node identifier | Required in ZooKeeper replicated scenarios |
| 8 | ZOOKEEPER\_SERVERS | - | Semicolon separated list of *host:port1:port2* where *port1* is used for follower connections, if the current node is the leader and *port2* is used for server connections during the leader election phase | - |
| 9 | ZOOKEEPER\_SYNC\_LIMIT | 5 | Timeouts ZooKeeper to limit how far out of date a server can be from a leader | - |
| 10 | ZOOKEEPER\_TOOLS\_LOG4J\_LOGLEVEL | WARN | - | - |
| 11 | ZOOKEEPER\_WEIGHTS | - | Semicolon separated list of indexed weights used for forming quorums | Optional, used in ZooKeeper replicated scenarios |

Moreover, these optional environment variables are also avaialbe:

| # | Environment variable name | ZooKeeper Configuration Parameter | Meaning | Default value |
|---|---|---|---|---|
| 1 | ZOOKEEPER\_TICK\_TIME | tickTime | The length of a single tick, which is the basic time unit used by ZooKeeper, as measured in milliseconds. It is used to regulate heartbeats, and timeouts | 2000 |
| 2 | ZOOKEEPER\_GLOBAL\_OUTSTANDING\_LIMIT | globalOutstandingLimit | Clients can submit requests faster than ZooKeeper can process them, especially if there are a lot of clients. To prevent ZooKeeper from running out of memory due to queued requests, ZooKeeper will throttle clients so that there is no more than globalOutstandingLimit outstanding requests in the system | 1000 |
| 3 | ZOOKEEPER\_PRE\_ALLOC\_SIZE | preAllocSize | To avoid seeks ZooKeeper allocates space in the transaction log file in blocks of preAllocSize kilobytes | 64M |
| 4 | ZOOKEEPER\_SNAP\_COUNT | snapCount | ZooKeeper logs transactions to a transaction log. After snapCount transactions are written to a log file a snapshot is started and a new transaction log file is created | 100000 |
| 5 | ZOOKEEPER\_TRACE\_FILE | traceFile | If this option is defined, requests will be will logged to a trace file named traceFile.year.month.day. Use of this option provides useful debugging information, but will impact performance | - |
| 6 | ZOOKEEPER\_MAX\_CLIENT\_CNXNS | maxClientCnxns | Limits the number of concurrent connections (at the socket level) that a single client, identified by IP address, may make to a single member of the ZooKeeper ensemble. This is used to prevent certain classes of DoS attacks, including file descriptor exhaustion | 60 |
| 7 | ZOOKEEPER\_CLIENT\_PORT\_ADDRESS | clientPortAddress | The address (ipv4, ipv6 or hostname) to listen for client connections; that is, the address that clients attempt to connect to | - |
| 8 | ZOOKEEPER\_MIN\_SESSION\_TIMEOUT | minSessionTimeout | The minimum session timeout in milliseconds that the server will allow the client to negotiate | 2 x tickTime |
| 9 | ZOOKEEPER\_MAX\_SESSION\_TIMEOUT | maxSessionTimeout | The maximum session timeout in milliseconds that the server will allow the client to negotiate | 20 x tickTime |
| 10 | ZOOKEEPER\_FSYNC\_WARNING\_THRESHOLDMS | fsync.warningthresholdms | A warning message will be output to the log whenever an fsync in the Transactional Log (WAL) takes longer than this value, in milliseconds | 1000 |
| 11 | ZOOKEEPER\_AUTOPURGE\_SNAP\_RETAIN\_COUNT | autopurge.snapRetainCount | When enabled, ZooKeeper auto purge feature retains the autopurge.snapRetainCount most recent snapshots and the corresponding transaction logs in the dataDir and dataLogDir respectively and deletes the rest. Minimum value is 3 | 3 |
| 12 | ZOOKEEPER\_AUTOPURGE\_PURGE\_INTERVAL | autopurge.purgeInterval | The time interval in hours for which the purge task has to be triggered. Set to a positive integer (1 and above) to enable the auto purging | 0 |
| 13 | ZOOKEEPER\_SYNC\_ENABLED | syncEnabled | The observers now log transaction and write snapshot to disk by default like the participants. This reduces the recovery time of the observers on restart. Set to "false" to disable this feature | true |
| 14 | ZOOKEEPER\_ELECTION\_ALG | electionAlg | Election implementation to use. A value of "0" corresponds to the original UDP-based version, "1" corresponds to the non-authenticated UDP-based version of fast leader election, "2" corresponds to the authenticated UDP-based version of fast leader election, and "3" corresponds to TCP-based version of fast leader election | 3 |
| 15 | ZOOKEEPER\_INIT\_LIMIT | initLimit | Amount of time, in ticks, to allow followers to connect and sync to a leader | - |
| 16 | ZOOKEEPER\_LEADER\_SERVES | leaderServes | Leader accepts client connections | yes |
| 17 | ZOOKEEPER\_SYNC\_LIMIT | syncLimit | Amount of time, in ticks, to allow followers to sync with ZooKeepe | - |
| 18 | ZOOKEEPER\_CNX\_TIMEOUT | cnxTimeout | Sets the timeout value for opening connections for leader election notifications. Only applicable if you are using electionAlg 3 | - |
| 19 | ZOOKEEPER\_FORCE\_SYNC | forceSync | Requires updates to be synced to media of the transaction log before finishing processing the update | - |
| 20 | ZOOKEEPER\_JUTE\_MAX\_BUFFER | jute.maxbuffer | It specifies the maximum size of the data that can be stored in a znode | 0xfffff |
| 21 | ZOOKEEPER\_SKIP\_ACL | skipACL | Skips ACL checks. This results in a boost in throughput, but opens up full access to the data tree to everyone | - |
| 22 | ZOOKEEPER\_QUORUM\_LISTEN\_ON\_ALL\_IPS | quorumListenOnAllIPs | When set to true the ZooKeeper server will listen for connections from its peers on all available IP addresses, and not only the address configured in the server list of the configuration file. It affects the connections handling the ZAB protocol and the Fast Leader Election protocol | false |

For more information, check the [Apache ZooKeeper's Official Documentation].

### Dual licensed under: ###

* [Apache License]
* [Oracle Binary Code License Agreement]

   [docker-utils]: <https://github.com/confluentinc/cp-docker-images/tree/master/java>
   [Confluent Open Source Platform]: <https://www.confluent.io/product/confluent-open-source/>
   [Apache ZooKeeper]: <https://zookeeper.apache.org/>   
   [Apache ZooKeeper's Official Documentation]: <http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html>
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-zookeeper/blob/jesse-slim-8u144-2.11.11-3.2.2/Dockerfile>
   [jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-zookeeper/blob/jesse-slim-8u144-2.11.11-3.3.0/Dockerfile>
   [Confluent utility belt script ('cub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/cub>
   [Docker utility belt script ('dub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/dub>  
   [repository]: <https://github.com/confluentinc/cp-docker-images>
   [3.2.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.2.x>
   [3.3.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.3.x>   
   [confluent-osp-base]: <https://hub.docker.com/r/mbe1224/confluent-osp-base/>
   [Apache License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-zookeeper/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-zookeeper/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>