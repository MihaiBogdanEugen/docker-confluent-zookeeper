FROM mbe1224/confluent-osp-base:jesse-slim-8u144-2.11.11-3.3.0

EXPOSE 2181 2888 3888

ENV COMPONENT=zookeeper

RUN echo "===> installing ${COMPONENT}..." \
    && apt-get update && apt-get install -y confluent-kafka-${SCALA_VERSION}=${KAFKA_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
    && echo "===> clean up ..." \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \
    && echo "===> Setting up ${COMPONENT} dirs" \
    && mkdir -p /var/lib/${COMPONENT}/data /var/lib/${COMPONENT}/log /etc/${COMPONENT}/secrets /etc/confluent/docker \
    && chmod -R ag+w /etc/kafka /var/lib/${COMPONENT}/data /var/lib/${COMPONENT}/log /etc/${COMPONENT}/secrets \
    && wget "https://github.com/confluentinc/cp-docker-images/blob/71fabd107216be2be86aea2b95371cdea4abde95/debian/zookeeper/include/etc/confluent/docker/configure" -O "/etc/confluent/docker/configure" \
    && wget "https://github.com/confluentinc/cp-docker-images/blob/71fabd107216be2be86aea2b95371cdea4abde95/debian/zookeeper/include/etc/confluent/docker/ensure" -O "/etc/confluent/docker/ensure" \
    && wget "https://github.com/confluentinc/cp-docker-images/blob/71fabd107216be2be86aea2b95371cdea4abde95/debian/zookeeper/include/etc/confluent/docker/launch" -O "/etc/confluent/docker/launch" \
    && wget "https://github.com/confluentinc/cp-docker-images/blob/71fabd107216be2be86aea2b95371cdea4abde95/debian/zookeeper/include/etc/confluent/docker/log4j.properties.template" -O "/etc/confluent/docker/log4j.properties.template" \
    && wget "https://github.com/confluentinc/cp-docker-images/blob/71fabd107216be2be86aea2b95371cdea4abde95/debian/zookeeper/include/etc/confluent/docker/myid.template" -O "/etc/confluent/docker/myid.template" \
    && wget "https://github.com/confluentinc/cp-docker-images/blob/71fabd107216be2be86aea2b95371cdea4abde95/debian/zookeeper/include/etc/confluent/docker/run" -O "/etc/confluent/docker/run" \
    && wget "https://github.com/confluentinc/cp-docker-images/blob/71fabd107216be2be86aea2b95371cdea4abde95/debian/zookeeper/include/etc/confluent/docker/tools-log4j.properties.template" -O "/etc/confluent/docker/tools-log4j.properties.template" \
    && wget "https://github.com/confluentinc/cp-docker-images/blob/71fabd107216be2be86aea2b95371cdea4abde95/debian/zookeeper/include/etc/confluent/docker/zookeeper.properties.template" -O "/etc/confluent/docker/zookeeper.properties.template" \
    && chmod a+x "/etc/confluent/docker/configure" \
    && chmod a+x "/etc/confluent/docker/ensure" \
    && chmod a+x "/etc/confluent/docker/launch" \
    && chmod a+x "/etc/confluent/docker/run"

VOLUME ["/var/lib/${COMPONENT}/data", "/var/lib/${COMPONENT}/log", "/etc/${COMPONENT}/secrets"]

CMD ["/etc/confluent/docker/run"]