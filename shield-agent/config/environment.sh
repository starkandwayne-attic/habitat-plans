#!/bin/bash
{{ #with bind.daemon.first }}
SHIELD_ENDPOINT="http://{{sys.ip}}:{{cfg.port}}"
{{~/with}}
