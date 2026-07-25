# EC2 Setup

この手順は「このEC2上から AWS CLI で CloudFormation を実行し、WAF用EC2を作成する」前提です。

## 1. Prerequisites on control EC2
- AWS CLI が利用可能
- CloudFormation 実行権限を持つ IAM 権限
- 対象 VPC / Subnet / KeyPair を把握済み

確認コマンド:
```bash
aws sts get-caller-identity
aws configure get region
```

## 2. Deploy stack
```bash
./scripts/cfn-deploy.sh <stack-name> <key-name> <vpc-id> <subnet-id> [instance-type]
```

このスクリプトは `infra/cloudformation/waf-ec2.yaml` を使って次を実行します。
- WAF用EC2起動
- Security Group 作成
- user-data で Docker / Compose 導入
- `owasp/modsecurity-crs` コンテナ起動

## 3. Validate
Stack output の `PublicIp` または `PublicDnsName` で確認:
```bash
./scripts/verify.sh http://<WAF_EC2_PUBLIC_IP_OR_DNS>
```

## 4. Delete stack
```bash
./scripts/cfn-delete.sh <stack-name>
```

## 5. Optional: manual mode on a host
CloudFormation を使わない場合は、`infra/ec2/user-data.sh` と `infra/docker/` + `scripts/deploy.sh` を使用します。
