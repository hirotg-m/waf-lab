# Operations

## Useful Commands
```bash
./scripts/cfn-deploy.sh <stack-name> <key-name> <vpc-id> <subnet-id> [instance-type]
./scripts/cfn-delete.sh <stack-name>
./scripts/deploy.sh
./scripts/logs.sh
./scripts/verify.sh
```

## Tuning Workflow
1. Start with `MODSEC_RULE_ENGINE=DetectionOnly` if false positives are unknown.
2. Inspect logs and identify noisy rules.
3. Add local exceptions to `config/modsecurity/custom-rules.conf`.
4. Switch to `MODSEC_RULE_ENGINE=On` once validated.

## Upgrade
```bash
docker compose --env-file infra/docker/.env -f infra/docker/docker-compose.yml pull
docker compose --env-file infra/docker/.env -f infra/docker/docker-compose.yml up -d
```

## Backup/Restore Notes
- Keep `.env` and `custom-rules.conf` in version control strategy you trust.
- Avoid storing secrets directly in repository.
