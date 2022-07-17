#!/bin/bash
set -euo pipefail

find . -name "*.php" -print0 | xargs -0 -n1 php -l
find . -name "*.json" -not -path "*/node_modules/*" -print0 | xargs -0 python3 ./tools/json_verifier.py

if [ -z "$LD_LIBRARY_PATH" ]; then
	export LD_LIBRARY_PATH=""
fi
source /home/runner/BYOND/byond/bin/byondsetup

bash tools/build/build --ci lint tgui-test
