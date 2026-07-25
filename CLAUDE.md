# CLAUDE.md

## Purpose
This repository builds and operates an EC2-hosted WAF using `owasp/modsecurity-crs`.

## Development Priorities
1. Keep infrastructure simple and reproducible.
2. Prefer small, reviewable changes.
3. Preserve secure defaults; document exceptions.

## Guardrails
- Do not commit secrets or private keys.
- Keep ModSecurity rule changes in `config/modsecurity/custom-rules.conf`.
- Update docs in `docs/` when changing deployment behavior.

## Common Tasks
- Deploy: `./scripts/deploy.sh`
- Tail logs: `./scripts/logs.sh`
- Verify baseline behavior: `./scripts/verify.sh`
