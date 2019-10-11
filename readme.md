
# MySQL Group Replication

## Tech Stack
- Docker
- MySQL 5.7
- HAProxy
- Apache2

## Running All Services
```bash
docker-compose build
docker-compose --compatibility up

# To run in background
docker-compose up -d
```

## Starting/Stopping Single Service
```bash
docker-compose start <service>
docker-compose stop <service>

# Example
docker-compose start web_server
docker-compose stop web_server
```

## Destroying All Services
```bash
docker-compose down
docker volume rm bdt_ets_web_server
docker volume rm bdt_ets_db_server1
docker volume rm bdt_ets_db_server2
docker volume rm bdt_ets_db_server3
```