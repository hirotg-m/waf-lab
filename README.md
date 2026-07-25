# waf-lab

AWS EC2 上で `owasp/modsecurity-crs` コンテナを使って WAF を構築・検証するためのリポジトリです。

## Directory Layout

```
waf-lab/
	.github/
		copilot-instructions.md
	config/
		modsecurity/
			custom-rules.conf
	docs/
		architecture.md
		ec2-setup.md
		operations.md
		requirements.md
	infra/
		cloudformation/
			waf-ec2.yaml
		docker/
			docker-compose.yml
			.env.example
		ec2/
			user-data.sh
	scripts/
		cfn-deploy.sh
		cfn-delete.sh
		deploy.sh
		logs.sh
		verify.sh
	CLAUDE.md
	Makefile
```

## Quick Start

### A. CloudFormation from this EC2 (AWS CLI)

1. Confirm AWS credentials and region on this EC2.

```bash
aws sts get-caller-identity
aws configure get region
```

2. Deploy WAF EC2 stack.

```bash
./scripts/cfn-deploy.sh <stack-name> <key-name> <vpc-id> <subnet-id> [instance-type]
```

3. Check output (`PublicIp` or `PublicDnsName`) and validate.

```bash
./scripts/verify.sh http://<WAF_EC2_PUBLIC_IP_OR_DNS>
```

### B. Manual host setup (optional)

1. Prepare environment file.

```bash
cp infra/docker/.env.example infra/docker/.env
```

2. Edit `infra/docker/.env` and set `BACKEND` to your upstream app.

3. Deploy WAF container.

```bash
./scripts/deploy.sh
```

4. Verify behavior.

```bash
./scripts/verify.sh http://<EC2_PUBLIC_DNS_OR_IP>
```

## AI Assistants

- GitHub Copilot guidance: `.github/copilot-instructions.md`
- Claude Code guidance: `CLAUDE.md`

## Next Reading

- Requirements: `docs/requirements.md`
- EC2 setup: `docs/ec2-setup.md`
- Architecture: `docs/architecture.md`
- Operations and tuning: `docs/operations.md`