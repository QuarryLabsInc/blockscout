#!/bin/bash
# Stop Blockscout explorer (run from blockscout directory)

set -e

echo "=========================================="
echo "Stopping QuarryChain Explorer"
echo "=========================================="
echo ""

# Check if docker is available
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is required but not installed"
    exit 1
fi

# Use docker compose (v2) if available, otherwise docker-compose (v1)
if docker compose version &> /dev/null 2>&1; then
    COMPOSE_CMD="docker compose"
elif command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
else
    echo "Error: Docker Compose is required but not found"
    exit 1
fi

cd docker-compose

echo "Stopping Blockscout services..."
echo ""

$COMPOSE_CMD down "$@"

echo ""
echo "=========================================="
echo "Explorer stopped!"
echo "=========================================="
echo ""
