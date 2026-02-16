#!/bin/bash
set -e

if [[ "$1" == "rincoin-cli" || "$1" == "rincoin-tx" || "$1" == "rincoind" || "$1" == "test_rincoin" ]]; then
	mkdir -p "$RINCOIN_DATA"

	chown -h rincoin:rincoin /home/rincoin/.rincoin
	exec gosu rincoin "$@"
else
	exec "$@"
fi
