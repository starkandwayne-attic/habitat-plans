#!/bin/bash

SHIELD_ENDPOINT='{{cfg.shield_endpoint}}'
SHIELD_API_TOKEN='{{cfg.provisioning_key}}'

{{ #each bind.daemon.members as |shield| }}
{{ #unless shield.follower }}
# Overriding with values found in binding
SHIELD_ENDPOINT='https://{{shield.sys.ip}}:{{shield.cfg.port}}'
SHIELD_API_TOKEN='{{shield.cfg.provisioning_key}}'
{{ /unless }}
{{~/each}}
