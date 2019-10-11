FROM ubuntu:18.04

RUN apt update &&\
    apt upgrade -y

RUN apt install -y htop nano curl libaio1 haproxy\
    libmecab2 libnuma1 perl psmisc net-tools uuid-runtime

RUN apt install -y mysql-client

CMD /bin/bash -c "/bin/bash /root/startup.sh; tail -f /dev/null"
