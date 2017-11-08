FROM mbe1224/confluent-base:3.2.2

ENV COMPONENT=zookeeper

EXPOSE 2181 2888 3888

RUN echo "===> installing ${COMPONENT}..." \
    && apt-get update && apt-get install -y confluent-kafka-${SCALA_VERSION}=${KAFKA_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
    && echo "===> clean up ..." \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \
    && echo "===> Setting up ${COMPONENT} dirs" \
    && mkdir -p /var/lib/${COMPONENT}/data /var/lib/${COMPONENT}/log /etc/${COMPONENT}/secrets /etc/confluent/docker \
    && chmod -R ag+w /etc/kafka /var/lib/${COMPONENT}/data /var/lib/${COMPONENT}/log /etc/${COMPONENT}/secrets \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/${COMMIT_SHA}/debian/zookeeper/include/etc/confluent/docker/configure" -O "/etc/confluent/docker/configure" \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/${COMMIT_SHA}/debian/zookeeper/include/etc/confluent/docker/ensure" -O "/etc/confluent/docker/ensure" \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/${COMMIT_SHA}/debian/zookeeper/include/etc/confluent/docker/launch" -O "/etc/confluent/docker/launch" \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/${COMMIT_SHA}/debian/zookeeper/include/etc/confluent/docker/log4j.properties.template" -O "/etc/confluent/docker/log4j.properties.template" \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/${COMMIT_SHA}/debian/zookeeper/include/etc/confluent/docker/myid.template" -O "/etc/confluent/docker/myid.template" \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/${COMMIT_SHA}/debian/zookeeper/include/etc/confluent/docker/run" -O "/etc/confluent/docker/run" \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/${COMMIT_SHA}/debian/zookeeper/include/etc/confluent/docker/tools-log4j.properties.template" -O "/etc/confluent/docker/tools-log4j.properties.template" \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/${COMMIT_SHA}/debian/zookeeper/include/etc/confluent/docker/zookeeper.properties.template" -O "/etc/confluent/docker/zookeeper.properties.template" \
    && chmod a+x "/etc/confluent/docker/configure" \
    && chmod a+x "/etc/confluent/docker/ensure" \
    && chmod a+x "/etc/confluent/docker/launch" \
    && chmod a+x "/etc/confluent/docker/run"

VOLUME ["/var/lib/${COMPONENT}/data", "/var/lib/${COMPONENT}/log", "/etc/${COMPONENT}/secrets"]

CMD ["/etc/confluent/docker/run"]