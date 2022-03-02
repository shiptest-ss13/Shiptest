#!/usr/bin/env bash
set -euo pipefail

source dependencies.sh

mkdir -p ~/.byond/bin
wget -O ~/.byond/bin/libauxmos.so "https://github.com/Putnam3145/auxmos/releases/download/${AUXMOS_VERSION}/libauxmos.so"
chmod +x ~/.byond/bin/libauxmos.so
ldd ~/.byond/bin/libauxmos.so
