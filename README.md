## Docker [ZooKeeper] image for the [Confluent Open Source Platform] using [Scala] and [Oracle JDK] ##

### Supported tags and respective Dockerfile links: ###

* ```3.2.2``` _\([3.2.2/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/docker-confluent-platform-zookeeper:3.2.2.svg)](https://microbadger.com/images/mbe1224/docker-confluent-platform-zookeeper:3.2.2 "")
* ```3.3.0```, ```latest``` _\([3.3.0/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/docker-confluent-platform-zookeeper:3.3.0.svg)](https://microbadger.com/images/mbe1224/docker-confluent-platform-zookeeper:3.3.0 "")

#### All tag names follow the naming convention: ####

```confluent_platform_version```

### About: ### 

#### Summary: ####

- Debian "slim" image variant
- Oracle JDK 8u152 addded, without MissionControl, VisualVM, JavaFX, ReadMe files, source archives, etc.
- Oracle Java Cryptography Extension added
- Scala 2.11.11 added
- Python 2.7.9-1 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME and SCALA\_HOME environment variables set up
- Utility scripts added:
    - [Confluent utility belt script ('cub')]
    - [Docker utility belt script ('dub')]
- ZooKeeper 3.4.9 added

#### More details: ####

This image was created with the sole purpose of offering the [Confluent Open Source Platform] running on top of [Oracle JDK].
Therefore, it follows the same structure as the one from the original [repository]. More precisely:
- tag ```3.2.2``` follows branch [3.2.x], and 
- tags ```3.3.0``` and```latest``` follow branch [3.3.x]


Apart of the base image ([confluent-platform-base]), it has Apache ZooKeeper added on top of it, installed using the following Confluent Debian package:
- ```confluent-kafka-2.11```

### Usage: ###

Build the image
```shell
docker build -t mbe1224/confluent-platform-zookeeper /3.3.0/
```

Run the container
```shell
docker run -d \
    --net=host \
    --name=zookeeper \
    -e ZOOKEEPER_CLIENT_PORT=32181 \
    mbe1224/confluent-platform-zookeeper
```

### Environment variables: ###

One can use the following environment variables for configuring the ZooKeeper node:

| # | Name | Default value | Meaning | Comments |
|---|---|---|---|---|
| 1 | KAFKA\_JMX\_OPTS | - | JMX options used for monitoring | KAFKA_OPTS should contain 'com.sun.management.jmxremote.rmi.port' property |
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

### Dual licensed under: ###

* [MIT License]
* [Oracle Binary Code License Agreement]

   [Confluent Open Source Platform]: <https://www.confluent.io/product/confluent-open-source/>
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [Scala]: <https://www.scala-lang.org/>
   [ZooKeeper]: <https://zookeeper.apache.org/>   
   [3.2.2/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-confluent-platform-zookeeper/blob/master/3.2.2/Dockerfile>
   [3.3.0/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-confluent-platform-zookeeper/blob/master/3.3.0/Dockerfile>
   [Confluent utility belt script ('cub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/cub>
   [Docker utility belt script ('dub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/dub>  
   [repository]: <https://github.com/confluentinc/cp-docker-images>
   [3.2.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.2.x>
   [3.3.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.3.x>   
   [confluent-platform-base]: <https://hub.docker.com/r/mbe1224/confluent-platform-base/>
   [MIT License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/docker-confluent-platform-zookeeper/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/docker-confluent-platform-zookeeper/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>