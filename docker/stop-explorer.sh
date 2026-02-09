#!/bin/bash
# Stop Blockscout explorer (run from blockscout/docker or blockscout)
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../docker-compose"
if docker compose version &>/dev/null 2>&1; then
    docker compose down "$@"
else
    docker-compose down "$@"
fi
