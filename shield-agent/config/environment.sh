#!/bin/bash
{{ #with bind.daemon.members.[0] }}
SHIELD_ENDPOINT="http://{{sys.ip}}:{{cfg.port}}"
{{~/with}}
