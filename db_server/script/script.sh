#!/bin/bash

apt update

cd /tmp

# Getting MySQL binaries
curl -OL https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-common_5.7.23-1ubuntu16.04_amd64.deb
curl -OL https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-client_5.7.23-1ubuntu16.04_amd64.deb
curl -OL https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-client_5.7.23-1ubuntu16.04_amd64.deb
curl -OL https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-server_5.7.23-1ubuntu16.04_amd64.deb

# Setting input for installation
debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password admin'
debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password admin'

# Installing MySQL Community Server
dpkg -i mysql-common_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-community-client_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-client_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-community-server_5.7.23-1ubuntu16.04_amd64.deb