#!/bin/bash

sed -i "s/.*loose-group_replication_group_name.*/loose-group_replication_group_name = ${GROUP_NAME}/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_ip_whitelist.*/loose-group_replication_ip_whitelist = ${IP_WHITELIST}/" /etc/mysql/my.cnf
sed -i "s/.*loose-group_replication_group_seeds.*/loose-group_replication_group_seeds = ${GROUP_SEEDS}/" /etc/mysql/my.cnf