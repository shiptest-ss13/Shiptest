#!/bin/bash
set -euo pipefail

source dependencies.sh

find . -name "*.php" -print0 | xargs -0 -n1 php -l
find . -name "*.json" -not -path "*/node_modules/*" -print0 | xargs -0 python3 ./tools/json_verifier.py

source $HOME/BYOND/byond/bin/byondsetup
tools/build/build --ci lint tgui-test
