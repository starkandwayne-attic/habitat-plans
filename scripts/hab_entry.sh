#!/bin/bash

set -ex

service=$(cat /.hab_pkg)
service=$(echo "${service#*/}" | tr '[:lower:]' '[:upper:]')

env | \
  egrep "(HAB_)?${service}_.*=" | \
  sed "s/HAB_//" | \
  sed "s/${service}_\(.*\)=\(.*\)/\1 = \"\2\"/g" | \
  tr '[:upper:]' '[:lower:]' > /env.toml

eval "export HAB_${service}='$(cat /env.toml)'"

exec /init.sh "$@"

