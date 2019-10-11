INSTALL PLUGIN group_replication SONAME 'group_replication.so';

STOP GROUP_REPLICATION;

SET GLOBAL group_replication_bootstrap_group=ON;
START GROUP_REPLICATION;
SET GLOBAL group_replication_bootstrap_group=OFF;
