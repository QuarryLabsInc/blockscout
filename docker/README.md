# BlockScout Docker Integration

For usage instructions and ENV variables, see the [docker integration documentation](https://docs.blockscout.com/for-developers/deployment/docker-compose-deployment).

**Compose file location:** The stack is defined in `../docker-compose/`. Do not run `docker compose` from this `docker/` folder.

- **Start explorer:** from repo root run `./start-explorer.sh`
- **Stop explorer:** from this folder run `./stop-explorer.sh`, or from repo root run `cd docker-compose && docker compose down`