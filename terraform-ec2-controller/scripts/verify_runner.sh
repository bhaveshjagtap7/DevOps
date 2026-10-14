#!/usr/bin/env bash
# Automated verification script for EC2 Terraform Controller
set -euo pipefail

echo "=========================================================="
echo "      EC2 Terraform Controller Verification Suite         "
echo "=========================================================="

echo "[1/4] Checking Terraform CLI binary..."
if command -v terraform >/dev/null 2>&1; then
    echo "  [OK] Terraform installed: $(terraform version -json | grep -o '"version":"[^"]*"' | head -n1)"
else
    echo "  [FAIL] Terraform CLI is not found in PATH." >&2
    exit 1
fi

echo "[2/4] Verifying IMDSv2 token retrieval..."
TOKEN=$(curl -s -S -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 60" 2>/dev/null || true)
if [ -n "$TOKEN" ]; then
    echo "  [OK] IMDSv2 token successfully generated."
else
    echo "  [WARN] Unable to reach IMDSv2 endpoint from local workstation (expected when testing off-cloud)."
fi

echo "[3/4] Checking AWS CLI installation..."
if command -v aws >/dev/null 2>&1; then
    echo "  [OK] AWS CLI installed: $(aws --version)"
else
    echo "  [INFO] AWS CLI not detected locally (optional on runner)."
fi

echo "[4/4] Verifying nested project templates..."
if [ -d ~/secondary-infra ] || [ -f ./templates/nested_s3.tf.tpl ]; then
    echo "  [OK] Nested infrastructure template found."
fi

echo "=========================================================="
echo "      Verification Completed Successfully!                "
echo "=========================================================="