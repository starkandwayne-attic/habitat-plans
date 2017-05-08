#!/bin/bash

{{ #if bind.has_daemon }}
{{ #each bind.daemon.members as |shield| }}
{{ #unless shield.follower }}
SHIELD_ENDPOINT='https://{{shield.sys.ip}}:{{shield.cfg.port}}'
SHIELD_API_TOKEN='{{shield.cfg.provisioning_key}}'
{{ /unless }}
{{~/each}}
{{else}}
SHIELD_ENDPOINT='{{cfg.shield_endpoint}}'
SHIELD_API_TOKEN='{{cfg.provisioning_key}}'
{{ /if }}
