#!/bin/bash

# Changing the APT sources.list to kambing.ui.ac.id
cp sources.list '/etc/apt/sources.list'

apt update

# Get MySQL binaries
curl -OL https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-common_5.7.23-1ubuntu16.04_amd64.deb
curl -OL https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-client_5.7.23-1ubuntu16.04_amd64.deb
curl -OL https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-client_5.7.23-1ubuntu16.04_amd64.deb
curl -OL https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-community-server_5.7.23-1ubuntu16.04_amd64.deb

# Setting input for installation
debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password admin'
debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password admin'

# Install MySQL Community Server
dpkg -i mysql-common_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-community-client_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-client_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-community-server_5.7.23-1ubuntu16.04_amd64.deb

# Allow port on firewall
# ufw allow 33061
# ufw allow 3306

# Copy MySQL configurations
cp my1.cnf /etc/mysql/my.cnf

# Restart MySQL services
# service mysql restart

# Cluster bootstrapping
# mysql -u root -padmin < /vagrant/cluster_bootstrap.sql
# mysql -u root -padmin < /vagrant/addition_to_sys.sql
# mysql -u root -padmin < /vagrant/create_proxysql_user.sql