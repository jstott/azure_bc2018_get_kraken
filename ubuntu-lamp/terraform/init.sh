#!/bin/bash
set -eo pipefail
terraform init

# Ignore any errors if workspace already exists - no harm, no foul as they say
terraform workspace new sandbox || true
terraform workspace new qa || true
terraform workspace new dev || true