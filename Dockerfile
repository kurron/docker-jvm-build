FROM kurron/docker-oracle-jdk-8:1.8.0_91c

MAINTAINER Ron Kurr <kurr@kurron.org>

LABEL org.kurron.ide.name="JVM Build" org.kurron.ide.version=1.8.0.91

RUN apt-get update && \
    apt-get install -y ca-certificates curl && \
    /usr/bin/curl --location --output /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.7.1/docker-compose-Linux-x86_64 && \ 
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN chmod 0555 /usr/local/bin/*

# So we can see any files that need to be evaluated
VOLUME ["/pwd"]

# We need to be able to communicate with the Docker engine
VOLUME ["/var/run/docker.sock"]

WORKDIR /pwd
CMD ["docker-compose", "--version"]
