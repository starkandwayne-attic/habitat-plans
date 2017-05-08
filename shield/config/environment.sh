#!/bin/bash
{{ #each bind.database.members as |db_node| }}
{{ #unless db_node.follower }}
PGPORT="{{db_node.cfg.port}}"
PGHOST="{{db_node.sys.ip}}"
PG_SUPERUSER="{{db_node.cfg.superuser_name}}"
PG_SUPERUSER_PASSWORD="{{db_node.cfg.superuser_password}}"
PG_SUPERUSER_URI="postgres://{{db_node.cfg.superuser_name}}:{{db_node.cfg.superuser_password}}@{{db_node.sys.ip}}:{{db_node.cfg.port}}/postgres"
{{ /unless }}
{{ /each }}
