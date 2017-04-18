#!/bin/bash

{{ #if bind.has_daemon }}
{{ #with bind.daemon.first }}
SHIELD_ENDPOINT='http://{{sys.ip}}:{{cfg.port}}'
SHIELD_API_TOKEN='{{cfg.provisioning_key}}'
{{~/with}}
{{else}}
SHIELD_ENDPOINT='{{cfg.shield_endpoint}}'
SHIELD_API_TOKEN='{{cfg.provisioning_key}}'
{{ /if }}
