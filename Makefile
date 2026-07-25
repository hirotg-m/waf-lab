SHELL := /usr/bin/env bash

.PHONY: help init deploy logs verify down ps cfn-deploy cfn-delete

help:
	@echo "Available targets:"
	@echo "  init   - copy .env example if missing"
	@echo "  deploy - pull and start WAF container"
	@echo "  logs   - follow WAF logs"
	@echo "  verify - run basic verification requests"
	@echo "  down   - stop and remove WAF container"
	@echo "  ps     - show compose service status"
	@echo "  cfn-deploy - create/update WAF EC2 stack via CloudFormation"
	@echo "  cfn-delete - delete WAF EC2 CloudFormation stack"

init:
	@if [[ ! -f infra/docker/.env ]]; then cp infra/docker/.env.example infra/docker/.env; fi
	@echo "infra/docker/.env is ready"

deploy:
	@./scripts/deploy.sh

logs:
	@./scripts/logs.sh

verify:
	@./scripts/verify.sh

down:
	docker compose --env-file infra/docker/.env -f infra/docker/docker-compose.yml down

ps:
	docker compose --env-file infra/docker/.env -f infra/docker/docker-compose.yml ps

cfn-deploy:
	@if [[ -z "$(STACK)" || -z "$(KEY)" || -z "$(VPC)" || -z "$(SUBNET)" ]]; then \
		echo "Usage: make cfn-deploy STACK=<name> KEY=<keypair> VPC=<vpc-id> SUBNET=<subnet-id> [TYPE=t3.small]"; \
		exit 1; \
	fi
	@./scripts/cfn-deploy.sh "$(STACK)" "$(KEY)" "$(VPC)" "$(SUBNET)" "$(or $(TYPE),t3.small)"

cfn-delete:
	@if [[ -z "$(STACK)" ]]; then echo "Usage: make cfn-delete STACK=<name>"; exit 1; fi
	@./scripts/cfn-delete.sh "$(STACK)"
