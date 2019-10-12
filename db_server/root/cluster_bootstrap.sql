INSTALL PLUGIN group_replication SONAME 'group_replication.so';

STOP GROUP_REPLICATION;

SET GLOBAL group_replication_bootstrap_group=ON;
START GROUP_REPLICATION;
SET GLOBAL group_replication_bootstrap_group=OFF;

CREATE USER 'haproxy_check'@'192.168.17.30';

GRANT ALL PRIVILEGES ON *.* TO 'haproxy_root'@'192.168.17.30' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS reservasi;