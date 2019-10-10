FROM ubuntu

RUN apt update &&\
    apt upgrade -y

RUN apt install -y htop nano mysql-server

RUN mkdir -p /var/run/mysqld

COPY . /tmp/

VOLUME /var/lib/mysql

CMD chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && mysqld_safe && /bin/bash