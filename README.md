# Concourse Examples

This repository contains a docker-compose.yml file that sets up a local development environment with Concourse CI, PostgreSQL, and HashiCorp Vault. This environment is useful for testing and experimenting with Concourse pipelines and integrating with Vault for secret management.

## Services
The docker-compose.yml file defines the following services:

*vault-server:* The HashiCorp Vault server, responsible for managing secrets.
*vault-client:* A client that connects to the Vault server. It can be used for testing and interacting with the Vault server.
*concourse-db:* A PostgreSQL database for Concourse to store its data.
*concourse:* The Concourse CI server, responsible for running pipelines and managing workers.

## Usage

To start the environment, run the following command in the directory containing the `docker-compose.yml` file:

```
docker-compose up -d
```

Once the environment is up and running, you can access the following services:

Concourse web interface: http://localhost:8080 (use test as both username and password)
Vault server: http://localhost:8200 (use the vault-plaintext-root-token as the root token)

To stop the environment and remove the containers, run:

```
docker-compose down
```

### Concourse cli login

```
fly --target tutorial login --concourse-url http://127.0.0.1:8080 -u test -p test
fly --target tutorial sync
```


## Pipelines

### basic/hello-world

```
fly -t tutorial set-pipeline -p hello-world -c hello-world.yml
# pipelines are paused when first created
fly -t tutorial unpause-pipeline -p hello-world
# trigger the job and watch it run to completion
fly -t tutorial trigger-job --job hello-world/hello-world-job --watch
```

### Events

```

```

## Credentials Manager

### Vault


