# Redis

This Redis plan supports standalone and clustered modes as well as bootstrapping from a backup taken via shield.

## Standalone

To run a standalone Redis instance simply run
```
hab start starkandwayne/redis
```
or
```
docker run starkandwayne/redis
```
if you want to bring up the pre-exported docker image.

## Cluster

This plan supports running clustered Redis by utilizing habitats native leader election.

You can run an example cluster via docker-compose:
```
cat <<EOF > docker-compose.yml
version: '3'

services:
  redis1:
    image: starkandwayne/redis
    command: "start starkandwayne/redis --group cluster --topology leader"
  redis2:
    image: starkandwayne/redis
    command: "start starkandwayne/redis --group cluster --topology leader --peer redis1"
  redis3:
    image: starkandwayne/redis
    command: "start starkandwayne/redis --group cluster --topology leader --peer redis1"
EOF

docker-compose up
```

Due to issues in habitat core such as https://github.com/habitat-sh/habitat/issues/2315 and https://github.com/habitat-sh/habitat/issues/1994 we recommend only to use the clustering features for demo purposes.

## Shield integration

If you have a shield daemon instance running (supervised via habitat or not) you can add configuration that will run regular backups and bootstrap an instance from a pre-existing backup. A `store` entity must be pre-configured in shield for this to work. In the example below a shield-agent is started just for this purpose.

Demo:

```
cat <<EOF > docker-compose.yml
version: '3'

services:
  redis:
    image: starkandwayne/redis:edge
    volumes:
    - backups-volume:/backups
    ports:
    - 6379:6379
    command: "start starkandwayne/redis --peer shield --group standalone --bind shield:shield.default"
    environment:
      HAB_REDIS: |
        bootstrap_from_backup=true
        backups_schedule='daily'
        backups_retention='shortterm'
        backups_store='default'
  shield:
    ports:
    - 443:443
    image: starkandwayne/shield
    command: "start starkandwayne/shield --peer database --bind database:postgresql.shield"
    links:
    - database
    - agent
  agent: # to autoprovision the dependant entities
    image: starkandwayne/shield-agent
    command: "start starkandwayne/shield-agent --bind daemon:shield.default --peer database"
    environment:
      HAB_SHIELD_AGENT: |
        [[stores]]
        name='default'
        plugin='fs'
        [stores.config]
        base_dir='/backups/redis'
        [schedules]
        daily='daily 4am'
        [retention-policies]
        shortterm='86400'
    links:
    - database
  database:
    image: starkandwayne/postgresql
    command: "start starkandwayne/postgresql --group shield"

volumes:
  backups-volume: {}
EOF

docker-compose up
```
> redis-cli -h ${REDIS_HOST} -a ${REDIS_PASSWORD} SET ${key} ${value}
