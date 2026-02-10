#!/bin/bash

# Startup script for Quarrychain Explorer (Blockscout)
# This script starts Blockscout explorer connected to Quarrychain Node 1

set -e

echo "=========================================="
echo "Starting Quarrychain Explorer"
echo "=========================================="
echo ""

# Check if Node 0 (Quarrychain) is running
if ! curl -s http://localhost:8540 > /dev/null 2>&1; then
    echo "Error: Quarrychain Node 0 JSON-RPC not accessible at http://localhost:8540"
    echo "Please start the nodes first with: cd ../evmos && ./start-validators.sh"
    exit 1
fi

echo "✓ Node 0 JSON-RPC is accessible"
echo ""

# Check if docker is available
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is required but not installed"
    exit 1
fi

# Use docker compose (v2) if available, otherwise docker-compose (v1)
if docker compose version &> /dev/null 2>&1; then
    COMPOSE_CMD="docker compose"
    echo "Using Docker Compose v2"
elif command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
    echo "Using Docker Compose v1"
else
    echo "Error: Docker Compose is required but not found"
    echo "Install Docker Compose or use Docker Desktop which includes it"
    exit 1
fi

cd docker-compose

echo "Starting Blockscout services..."
echo "This may take a few minutes on first run..."
echo ""

$COMPOSE_CMD up -d

echo ""
echo "=========================================="
echo "Explorer starting!"
echo "=========================================="
echo ""
echo "Services are starting up. This may take 2-5 minutes."
echo ""
echo "Check status:"
echo "  $COMPOSE_CMD ps"
echo ""
echo "View logs:"
echo "  $COMPOSE_CMD logs -f backend"
echo ""
echo "Once ready, access the explorer at:"
echo "  http://localhost"
echo ""
echo "To stop the explorer:"
echo "  ./stop-explorer.sh"
echo "  (or manually: cd docker-compose && $COMPOSE_CMD down)"
echo ""
