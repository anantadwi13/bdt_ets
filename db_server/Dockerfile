FROM ubuntu:16.04

RUN apt update &&\
    apt upgrade -y

RUN apt install -y htop nano curl libaio1\
    libmecab2 libnuma1 perl psmisc net-tools uuid-runtime

COPY ./script/script.sh /tmp/script.sh
COPY ./script/sources.list /etc/apt/sources.list

RUN /bin/bash /tmp/script.sh

RUN apt install -y netcat-traditional