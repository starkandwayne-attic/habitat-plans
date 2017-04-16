#!/bin/sh

set -ex

service=${HAB_SERVICE}

env | \
    grep "HAB_${HAB_SERVICE}" | \
      sed "s/HAB_${HAB_SERVICE}_\(.*\)=\(.*\)/\1 = '\2'/" | \
      tr '[:upper:]' '[:lower:]' > /config.toml

eval "export HAB_${HAB_SERVICE}='$(cat /config.toml)'"

exec /init.sh

