#!/bin/bash
set -e

if [[ "$1" == "yenten-cli" || "$1" == "yenten-tx" || "$1" == "yentend" || "$1" == "test_yenten" ]]; then
	mkdir -p "$YENTEN_DATA"

	chown -h yenten:yenten /home/yenten/.yenten
	exec gosu yenten "$@"
else
	exec "$@"
fi
