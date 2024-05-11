#!/bin/bash
set -euo pipefail

source dependencies.sh

mkdir -p "$HOME/auxmos"
pushd "$HOME/auxmos"

if [ ! -d .git ]
then
	git init
	git remote add origin https://github.com/Putnam3145/auxmos.git
fi

git fetch origin --depth=1 $AUXMOS_VERSION
git reset --hard FETCH_HEAD

rustup target add i686-unknown-linux-gnu

env PKG_CONFIG_ALLOW_CROSS=1 cargo build --release --target=i686-unknown-linux-gnu --features "all_reaction_hooks,katmos"

mkdir -p ~/.byond/bin
cp target/i686-unknown-linux-gnu/release/libauxmos.so  ~/.byond/bin/libauxmos.so
chmod +x ~/.byond/bin/libauxmos.so
ldd ~/.byond/bin/libauxmos.so

popd
