<h1 align="center">QuarryChain Explorer</h1>
<p align="center">Blockchain Explorer for QuarryChain Networks - Forked from Blockscout</p>
<div align="center">

[![Blockscout](https://github.com/blockscout/blockscout/actions/workflows/config.yml/badge.svg)](https://github.com/blockscout/blockscout/actions)
[![Discord](https://img.shields.io/badge/chat-Blockscout-green.svg)](https://discord.gg/blockscout)

</div>

---

## 🚀 QuarryChain Explorer Quick Start

This section provides step-by-step instructions to run the QuarryChain Blockscout explorer locally.

### Prerequisites

- **Docker** v20.10+ and **Docker Compose** 2.x+
- **Running QuarryChain validators** (see [../evmos/README.md](../evmos/README.md))

### Step 1: Start QuarryChain Validators

**Important:** The explorer requires the blockchain nodes to be running first.

```bash
cd ../evmos
./start-validators.sh
```

Wait for Node 0 to be fully synced. You can check the logs:
```bash
tail -f evmos/testnet-5validators/node0/node.log
```

The explorer connects to Node 0 at `http://localhost:8540` (JSON-RPC endpoint).

### Step 2: Start Blockscout Explorer

From the `blockscout` directory:

```bash
cd blockscout
./start-explorer.sh
```

**What this script does:**
- Checks if Node 0 JSON-RPC is accessible at `http://localhost:8540`
- Starts Docker Compose services (PostgreSQL, Redis, Backend, Frontend, Nginx)
- Configures connection to QuarryChain Node 0

**First-time startup:**
- Building Docker images may take 5-10 minutes
- Database migration runs automatically
- Services start in order: DB → Backend → Frontend → Nginx

### Step 3: Access the Explorer

Once services are ready (usually 2-5 minutes), access the explorer at:

**http://localhost**

**Check service status:**
```bash
cd blockscout/docker-compose
docker compose ps
```

**View logs:**
```bash
# Backend logs
docker compose logs -f backend

# Frontend logs
docker compose logs -f frontend

# All services
docker compose logs -f
```

### Step 4: Stop the Explorer

Use the helper script (same level as `start-explorer.sh`):

```bash
cd blockscout
./stop-explorer.sh
```

Or manually:
```bash
cd blockscout/docker-compose
docker compose down
```

### Configuration

**Backend environment variables:** `docker-compose/envs/common-blockscout.env`
- `ETHEREUM_JSONRPC_HTTP_URL`: `http://host.docker.internal:8540/`
- `ETHEREUM_JSONRPC_WS_URL`: `ws://host.docker.internal:8640/`
- `CHAIN_ID`: `9001`

**Frontend environment variables:** `docker-compose/envs/common-frontend.env`
- `NEXT_PUBLIC_NETWORK_NAME`: `QuarryChain`
- `NEXT_PUBLIC_NETWORK_ID`: `9001`
- `NEXT_PUBLIC_NETWORK_CURRENCY_SYMBOL`: `QRY`

**Custom branding:**
- Logo: `apps/block_scout_web/assets/static/images/blockscout_logo.svg`
- Custom CSS: `docker-compose/proxy/custom.css` (injected via Nginx)

### Troubleshooting

**502 Bad Gateway:**
- Ensure Node 0 is running: `curl http://localhost:8540`
- Check backend logs: `docker compose logs backend`
- Verify `RELEASE_VERSION` matches in `docker-compose.yml` (currently `9.3.2`)

**No transactions showing:**
- Send a test transaction (see [../evmos/SEND_TRANSACTIONS.md](../evmos/SEND_TRANSACTIONS.md))
- Check backend indexing: `docker compose logs backend | grep "indexing"`

**Frontend not loading:**
- Check frontend logs: `docker compose logs frontend`
- Verify `NEXT_PUBLIC_*` environment variables are set correctly
- Hard refresh browser (Ctrl+Shift+R)

**Port conflicts:**
- Default ports: 80 (Nginx), 4000 (Backend), 3000 (Frontend), 5432 (PostgreSQL), 6379 (Redis)
- Stop conflicting services or modify `docker-compose.yml`

---

## About Blockscout

Blockscout provides a comprehensive, easy-to-use interface for users to view, confirm, and inspect transactions on EVM (Ethereum Virtual Machine) blockchains. This includes Ethereum Mainnet, Ethereum Classic, Optimism, Gnosis Chain and many other **Ethereum testnets, private networks, L2s and sidechains**.

See our [project documentation](https://docs.blockscout.com/) for detailed information and setup instructions.

For questions, comments and feature requests see the [discussions section](https://github.com/blockscout/blockscout/discussions) or via [Discord](https://discord.com/invite/blockscout).

## Supported Projects

Blockscout currently supports several hundred chains and rollups throughout the greater blockchain ecosystem. Ethereum, Cosmos, Polkadot, Avalanche, Near and many others include Blockscout integrations. A comprehensive list is available at [chains.blockscout.com](https://chains.blockscout.com). If your project is not listed, contact the team in [Discord](https://discord.com/invite/blockscout).

## Getting Started (Original Blockscout)

See the [project documentation](https://docs.blockscout.com/) for instructions:

- [Manual deployment](https://docs.blockscout.com/for-developers/deployment/manual-deployment-guide)
- [Docker-compose deployment](https://docs.blockscout.com/for-developers/deployment/docker-compose-deployment)
- [Kubernetes deployment](https://docs.blockscout.com/for-developers/deployment/kubernetes-deployment)
- [Manual deployment (backend + old UI)](https://docs.blockscout.com/for-developers/deployment/manual-old-ui)
- [Ansible deployment](https://docs.blockscout.com/for-developers/ansible-deployment)
- [ENV variables](https://docs.blockscout.com/setup/env-variables)
- [Configuration options](https://docs.blockscout.com/for-developers/configuration-options)

## Acknowledgements

We would like to thank the EthPrize foundation for their funding support.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution and pull request protocol. We expect contributors to follow our [code of conduct](CODE_OF_CONDUCT.md) when submitting code or comments.

## License

[![License: GPL v3.0](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.
