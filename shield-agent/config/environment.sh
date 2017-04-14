#!/bin/bash
{{ #with bind.daemon.first }}
SHIELD_ENDPOINT="http://{{sys.ip}}:{{cfg.port}}"
SHIELD_API_TOKEN='{{cfg.provisioning_key}}'
{{~/with}}
