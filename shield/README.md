# Shield

This is a habitat plan for SHIELD a standalone system that can perform backup and restore functions for a wide variety of pluggable data systems. Please checkout the [github repo](https://github.com/starkandwayne/shield) for more information on the internals and how to use it.

## Dependencies
- shield-proxy (packed and run as side-car with shield)
- postgresql

## Running shield

First you will need to start postgresql to provide a persistent store for shield:

```
hab start starkandwayne/postgresql
```

Then bring up the daemon via:
```
hab start starkandwayne/shield --peer <pg-host> --bind database:postgresql.default
```

You can configure shield specific entities via the `shield` cli or by bringing up a `shield-agent` that will provision entities automaticaly.

```
cat <<EOF > agent-config.toml
[schedules]
auto = "daily 4am"
EOF
HAB_SHIELD_AGENT=$(cat agent-config.toml) hab start starkandwayne/shield-agent --peer <shield-host> --bind daemon:shield.default
```

## docker-compose example

```
cat <<EOF >docker-compose.yml
version: '3'

services:
  shield:
    image: starkandwayne/shield
    command: "start starkandwayne/shield --peer database --bind database:postgresql.shield"
    ports:
    - 443:443
    links:
    - database
  agent:
    image: starkandwayne/shield-agent
    command: "start starkandwayne/shield-agent --peer shield --bind daemon:shield.default"
    environment:
      HAB_SHIELD_AGENT: |
        [schedules]
        auto = "daily 4am"
  database:
    image: starkandwayne/postgresql:latest
    command: "start starkandwayne/postgresql --group shield"
EOF

docker-compose up
```
