#!/bin/bash
VAULT_RETRIES=5
echo "Vault is starting..."
until vault status > /dev/null 2>&1 || [ "$VAULT_RETRIES" -eq 0 ]; do
        echo "Waiting for vault to start...: $((VAULT_RETRIES--))"
        sleep 1
done
echo "Authenticating to vault..."
vault login token=vault-plaintext-root-token
echo "Initializing vault..."
vault secrets enable -version=2 -path=concourse kv
echo "Adding entries..."
vault kv put concourse/dev username=test_user
vault kv put concourse/dev password=test_password
vault policy write concourse ./concourse-policy.hcl

################
# Enable Approle
vault auth enable approle
# Only for dev purposes, period is long
vault write auth/approle/role/concourse policies=concourse period=1000h
echo "Complete..."
vault read auth/approle/role/concourse/role-id
vault write -f auth/approle/role/concourse/secret-id