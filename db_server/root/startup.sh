#!/bin/bash

# Copying mysql configuration
cp /root/my.cnf /etc/mysql/my.cnf

# Setting mysql configuration for each server
sed -i "s/.*server-uuid.*/server-uuid=${SERVER_UUID}/" /var/lib/mysql/auto.cnf
sed -i "s/.*loose-group_replication_group_name.*/loose-group_replication_group_name = ${GROUP_NAME}/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_ip_whitelist.*/loose-group_replication_ip_whitelist = ${IP_WHITELIST}/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_group_seeds.*/loose-group_replication_group_seeds = ${GROUP_SEEDS}/" /etc/mysql/my.cnf
sed -i "s/.*server_id.*/server_id = ${SERVER_ID}/" /etc/mysql/my.cnf
sed -i "s/.*bind-address.*/bind-address = \"${SERVER_IP}\"/" /etc/mysql/my.cnf
sed -i "s/.*report_host.*/report_host = \"${SERVER_IP}\"/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_local_address.*/loose-group_replication_local_address = \"${SERVER_IP}:${SERVER_REPLICATION_PORT}\"/" /etc/mysql/my.cnf

# Making server 1 as a bootstrapper
if [ ${SERVER_ID} -eq 1 ]; then 
    if ! nc -z 192.168.17.32 3306 && ! nc -z 192.168.17.33 3306; then
        sed -i "s/.*loose-group_replication_bootstrap_group.*/loose-group_replication_bootstrap_group = ON/" /etc/mysql/my.cnf
        echo 'Starting as bootstrap'
    fi
fi

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

rm -f /var/run/mysqld/mysqld.sock.lock

if [ ${SERVER_ID} -eq 1 ]; then 
    service mysql restart
else
    # This section is used for making each server as a bootstrapper when there is no server or group is running
    sleep 10
    if [ ${SERVER_ID} -eq 2 ] &&  ! nc -z 192.168.17.31 3306 && ! nc -z 192.168.17.33 3306; then
        sed -i "s/.*loose-group_replication_bootstrap_group.*/loose-group_replication_bootstrap_group = ON/" /etc/mysql/my.cnf
        echo 'Starting as bootstrap'
    fi
    if [ ${SERVER_ID} -eq 3 ] &&  ! nc -z 192.168.17.31 3306 && ! nc -z 192.168.17.32 3306; then
        sed -i "s/.*loose-group_replication_bootstrap_group.*/loose-group_replication_bootstrap_group = ON/" /etc/mysql/my.cnf
        echo 'Starting as bootstrap'
    fi
    service mysql restart
fi

# Executing sql once to configure group replication
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