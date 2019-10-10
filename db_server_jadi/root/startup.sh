#!/bin/bash

sed -i "s/.*loose-group_replication_group_name.*/loose-group_replication_group_name = ${GROUP_NAME}/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_ip_whitelist.*/loose-group_replication_ip_whitelist = ${IP_WHITELIST}/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_group_seeds.*/loose-group_replication_group_seeds = ${GROUP_SEEDS}/" /etc/mysql/my.cnf
sed -i "s/.*server_id.*/server_id = ${SERVER_ID}/" /etc/mysql/my.cnf
sed -i "s/.*bind-address.*/bind-address = \"${SERVER_IP}\"/" /etc/mysql/my.cnf
sed -i "s/.*report_host.*/report_host = \"${SERVER_IP}\"/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_local_address.*/loose-group_replication_local_address = \"${SERVER_IP}:${SERVER_REPLICATION_PORT}\"/" /etc/mysql/my.cnf

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

#nohup mysqld_safe &
service mysql start

if [ ${SERVER_ID} -eq 1 ]; then 
    mysql -u root -padmin < /root/cluster_bootstrap.sql
else 
    mysql -u root -padmin < /root/cluster_member.sql
fi

#service mysql stop