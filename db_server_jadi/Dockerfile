FROM ubuntu:16.04

RUN apt update &&\
    apt upgrade -y

RUN apt install -y htop nano curl libaio1\
    libmecab2 libnuma1 perl psmisc net-tools uuid-runtime

COPY ./script/script.sh /tmp/script.sh
COPY ./script/sources.list /etc/apt/sources.list

RUN /bin/bash /tmp/script.sh

#COPY ./script/startup.sh /root/startup.sh

#CMD /bin/bash -c "/bin/bash /root/startup.sh; chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; mysqld_safe"