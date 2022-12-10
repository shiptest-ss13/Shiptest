#!/bin/bash
set -euo pipefail

find . -name "*.php" -print0 | xargs -0 -n1 php -l
find . -name "*.json" -not -path "*/node_modules/*" -print0 | xargs -0 python3 ./tools/json_verifier.py
find ./_maps/configs -name "*.json" -not -path "/data/*" -print0 | xargs -0 python3 ./tools/json_schema_validator.py ./_maps/ship_config_schema.json
