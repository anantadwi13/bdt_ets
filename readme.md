
docker network create -d bridge --subnet=192.168.17.0/24 --gateway=192.168.17.1 bdt_ets
docker run -dit --memory="512m" --net=bdt_ets --ip=192.168.17.29 --name=db_server db_server

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld