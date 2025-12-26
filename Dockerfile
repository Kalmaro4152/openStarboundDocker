#syntax=docker/dockerfile:1
#Based off of the following Dockerfiles
#z0n/starbound-docker-steam
#morgyn/docker-starbound
#azure-owl/starbound-server
#nephatrine/docker-starbound-scmd

FROM ubuntu:latest

LABEL maintainer="kalmaro4152"

RUN apt update && apt upgrade -y && apt dist-upgrade -y && apt autoremove -y && apt install -y locales

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && apt update && apt install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    libc6-i386 \
    libcurl4 \
    libcurl4-openssl-dev \
    unzip wget curl ca-certificates

RUN apt install -y \
    software-properties-common \
    lib32gcc-s1 \
    libvorbisfile3 \
    libstdc++6

RUN adduser starbound

USER starbound

WORKDIR /home/starbound

RUN mkdir -p ./openStarbound

VOLUME ["/home/starbound/openStarbound"]

ADD --chown=starbound:starbound --chmod=u+rwx entry.sh /entry.sh

EXPOSE 21025/tcp

ENTRYPOINT ["/entry.sh"]
