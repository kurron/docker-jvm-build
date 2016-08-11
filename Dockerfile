FROM ubuntu:16.04

MAINTAINER Ron Kurr <kurr@kurron.org>

# So we can see any files that need to be evaluated
VOLUME ["/pwd"]

# We need to be able to communicate with the Docker engine
VOLUME ["/var/run/docker.sock"]

WORKDIR /pwd

LABEL org.kurron.jdk.version=1.8.0_101 org.kurron.docker.version=1.12.0 org.kurron.compose.version=1.8.0

ENV DEBIAN_FRONTEND noninteractive

# Make the JDK its own layer
RUN apt-get --quiet update && \
    apt-get --quiet --yes install wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget --quiet \
         --output-document=/jdk-8.tar.gz \
         --no-check-certificate \
         --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar --gunzip --extract --verbose --file /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

# Make the Docker stuff its own layer
RUN apt-get --quiet update && \
    apt-get --quiet --yes install  apt-transport-https ca-certificates curl && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' > /etc/apt/sources.list.d/docker.list && \
    apt-get --quiet update && \
    apt-cache policy docker-engine && \
    apt-get --quiet --yes install docker-engine && \
    /usr/bin/curl --location --output /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.8.0/docker-compose-Linux-x86_64 && \ 
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN chmod 0555 /usr/local/bin/*

CMD ["docker", "info"]
