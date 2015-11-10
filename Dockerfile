FROM debian:jessie

MAINTAINER Erin Swenson-Healey <l@s3r.me>

ENV STACK_VERSION 0.1.6.0
ENV STACK_DOWNLOAD_URL https://github.com/commercialhaskell/stack/releases/download/v$STACK_VERSION/stack-$STACK_VERSION-linux-x86_64.tar.gz
ENV DEBIAN_FRONTEND noninteractive
ENV PATH $PATH:/opt/bin

RUN apt-get update -q && \
    apt-get install -qy curl libgmp-dev build-essential xz-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /opt/bin && \
    curl -L $STACK_DOWNLOAD_URL | tar zx -C /opt/bin/ --wildcards '*/stack' --strip=1 && \
    chmod +x /opt/bin/stack

WORKDIR /src
