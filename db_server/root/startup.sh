#!/bin/bash

cd /tmp

# Setting input for installation
debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password admin'
debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password admin'

# Install MySQL Community Server
dpkg -i mysql-common_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-community-client_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-client_5.7.23-1ubuntu16.04_amd64.deb
dpkg -i mysql-community-server_5.7.23-1ubuntu16.04_amd64.deb


cp /root/my.cnf /etc/mysql/my.cnf

if [ ${SERVER_ID} -eq 1 ]; then 
    sed -i "s/.*loose-group_replication_bootstrap_group.*/loose-group_replication_bootstrap_group = ON/" /etc/mysql/my.cnf
fi

sed -i "s/.*loose-group_replication_group_name.*/loose-group_replication_group_name = ${GROUP_NAME}/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_ip_whitelist.*/loose-group_replication_ip_whitelist = ${IP_WHITELIST}/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_group_seeds.*/loose-group_replication_group_seeds = ${GROUP_SEEDS}/" /etc/mysql/my.cnf
sed -i "s/.*server_id.*/server_id = ${SERVER_ID}/" /etc/mysql/my.cnf
sed -i "s/.*bind-address.*/bind-address = \"${SERVER_IP}\"/" /etc/mysql/my.cnf
sed -i "s/.*report_host.*/report_host = \"${SERVER_IP}\"/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_local_address.*/loose-group_replication_local_address = \"${SERVER_IP}:${SERVER_REPLICATION_PORT}\"/" /etc/mysql/my.cnf

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

rm -f /var/run/mysqld/mysqld.sock.lock

service mysql restart

if  [ ! -f "/var/lib/mysql/initialized" ]; then
    mysql -u root -padmin < /root/cluster_init.sql
    touch /var/lib/mysql/initialized

    if [ ${SERVER_ID} -eq 1 ]; then 
        mysql -u root -padmin < /root/cluster_bootstrap.sql
    else 
        sleep 30
        mysql -u root -padmin < /root/cluster_member.sql
    fi
fi

#service mysql stop