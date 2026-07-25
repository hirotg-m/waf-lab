#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 4 ]]; then
  echo "Usage: $0 <stack-name> <key-name> <vpc-id> <subnet-id> [instance-type]"
  exit 1
fi

STACK_NAME="$1"
KEY_NAME="$2"
VPC_ID="$3"
SUBNET_ID="$4"
INSTANCE_TYPE="${5:-t3.small}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_FILE="$ROOT_DIR/infra/cloudformation/waf-ec2.yaml"

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    ProjectName=waf-lab \
    KeyName="$KEY_NAME" \
    VpcId="$VPC_ID" \
    SubnetId="$SUBNET_ID" \
    InstanceType="$INSTANCE_TYPE"

echo "\nStack outputs:"
aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --query "Stacks[0].Outputs[*].[OutputKey,OutputValue]" \
  --output table
