FROM mbe1224/confluent-osp-base:jesse-slim-8u144-2.11.11-3.2.2

EXPOSE 2181 2888 3888

ENV COMPONENT=zookeeper

RUN echo "===> installing ${COMPONENT}..." \
    && apt-get update && apt-get install -y confluent-kafka-${SCALA_VERSION}=${KAFKA_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
    && echo "===> clean up ..."  \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \
    && echo "===> Setting up ${COMPONENT} dirs" \
    && mkdir -p /var/lib/${COMPONENT}/data /var/lib/${COMPONENT}/log /etc/${COMPONENT}/secrets  /etc/confluent/docker  \
    && chmod -R ag+w /etc/kafka /var/lib/${COMPONENT}/data /var/lib/${COMPONENT}/log /etc/${COMPONENT}/secrets \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/zookeeper/include/etc/confluent/docker/configure" -O "/etc/confluent/docker/configure" \
    && echo "dc09cad3081f94651e6361c64ac64dad784ddf37f565264b55510a36e0777ff5" "/etc/confluent/docker/configure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/zookeeper/include/etc/confluent/docker/ensure" -O "/etc/confluent/docker/ensure" \
    && echo "9664120b226b9078567c0d4cd9813d572b9ad5e9db0d0042ab470ea0835ed3bf" "/etc/confluent/docker/ensure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/zookeeper/include/etc/confluent/docker/launch" -O "/etc/confluent/docker/launch" \
    && echo "ad5dbb1122fa7dea26826b4c951ab74682236361f7732a9178aa1de84706b10e" "/etc/confluent/docker/launch" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/zookeeper/include/etc/confluent/docker/log4j.properties.template" -O "/etc/confluent/docker/log4j.properties.template" \
    && echo "3546a01e374547dd4365fd59d03ce47b0d41e784cb8671969da7e28a49dfa7f2" "/etc/confluent/docker/log4j.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/zookeeper/include/etc/confluent/docker/myid.template" -O "/etc/confluent/docker/myid.template" \
    && echo "f53f54418bcc6b75a8012a48038e375f8fd892d94081c700e5fadd67793a2c1b" "/etc/confluent/docker/myid.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/zookeeper/include/etc/confluent/docker/run" -O "/etc/confluent/docker/run" \
    && echo "4a83d37b42ca102b8d27ff7bfca74f70499bf8db22991d5732bdaf137afcb5a5" "/etc/confluent/docker/run" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/zookeeper/include/etc/confluent/docker/tools-log4j.properties.template" -O "/etc/confluent/docker/tools-log4j.properties.template" \
    && echo "210e2cc62d2f06b15d1b2af5ff6b41bade3e20b8d36d36dfc6f81c7ecb68d1cc" "/etc/confluent/docker/tools-log4j.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/zookeeper/include/etc/confluent/docker/zookeeper.properties.template" -O "/etc/confluent/docker/zookeeper.properties.template" \
    && echo "92d6b57fab087f278b8c7e488554865d1b4f627dcde3c73214599ed558fa1c53" "/etc/confluent/docker/zookeeper.properties.template" | sha256sum -c -

VOLUME ["/var/lib/${COMPONENT}/data", "/var/lib/${COMPONENT}/log", "/etc/${COMPONENT}/secrets"]

CMD ["/etc/confluent/docker/run"]




