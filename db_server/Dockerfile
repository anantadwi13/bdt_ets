FROM ubuntu

RUN apt update &&\
    apt upgrade -y

RUN apt install -y htop nano curl libaio1\
    libmecab2 libnuma1 perl psmisc net-tools

COPY . /root/

RUN cd /root/ &&\
    /bin/bash script1.sh

CMD /bin/bash /root/startup.sh && /bin/bash