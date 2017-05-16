# PostgreSQL

This PostgreSQL plan supports standalone and clustered modes as well as continuous archiving via wal-e integration.

## Standalone

To run a standalone PostgreSQL instance simply run
```
hab start starkandwayne/PostgreSQL
```
or
```
docker run starkandwayne/PostgreSQL
```
if you want to bring up the pre-exported docker image.

## Cluster

This plan supports running clustered PostgreSQL by utilizing habitats native leader election.

You can run an example cluster via docker-compose:
```
cat <<EOF > docker-compose.yml
version: '2'

services:
  pg1:
    image: starkandwayne/postgresql
    command: "start starkandwayne/postgresql --group cluster --topology leader"
  pg2:
    image: starkandwayne/postgresql
    command: "start starkandwayne/postgresql --group cluster --topology leader --peer pg1"
  pg3:
    image: starkandwayne/postgresql
    command: "start starkandwayne/postgresql --group cluster --topology leader --peer pg1"
EOF

docker-compose up
```

## Binding

Consuming services can bind to PostgreSQL via:

```
hab start <origin>/<app> --bind database:PostgreSQL.default --peer <pg-host>
```



