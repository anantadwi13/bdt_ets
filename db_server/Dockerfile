FROM ubuntu:16.04

RUN apt update &&\
    apt upgrade -y

# Installing dependencies
RUN apt install -y htop netcat-traditional nano curl libaio1\
    libmecab2 libnuma1 perl psmisc net-tools uuid-runtime

# Copying script
COPY ./script/script.sh /tmp/script.sh
COPY ./script/sources.list /etc/apt/sources.list

# Execute above script
RUN /bin/bash /tmp/script.sh