#!/usr/bin/env bash
set -euo pipefail

source dependencies.sh

#mkdir -p ~/.byond/bin
#wget -O ~/.byond/bin/libauxmos.so "https://github.com/austation/auxmos/releases/download/${AUXMOS_VERSION}/libauxmos.so"
chmod +x libauxmos.so
ldd libauxmos.so
