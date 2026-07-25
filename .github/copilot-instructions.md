# Copilot Instructions for waf-lab

## Project Context
- This repository is for an AWS EC2 WAF lab.
- Core runtime is `owasp/modsecurity-crs:nginx`.
- Deployment artifacts live under `infra/` and `scripts/`.
- Primary provisioning path is AWS CLI + CloudFormation from a control EC2 host.

## Coding Preferences
- Favor Bash and YAML changes that are explicit and easy to audit.
- Keep scripts POSIX-friendly where possible; fail fast with `set -euo pipefail`.
- Add concise comments only where behavior is non-obvious.

## Security Requirements
- Never introduce hard-coded credentials or tokens.
- Keep secure defaults for ModSecurity and document any relaxation.
- Route local rule overrides to `config/modsecurity/custom-rules.conf`.

## Documentation Rule
If code or deployment behavior changes, update at least one relevant file in `docs/`.

## Preferred Deployment Flow
1. `scripts/cfn-deploy.sh` with `infra/cloudformation/waf-ec2.yaml`
2. Validate stack outputs and runtime behavior
3. Use manual Docker flow only as secondary fallback
