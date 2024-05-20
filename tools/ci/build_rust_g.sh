#!/bin/bash
set -euo pipefail

source dependencies.sh

mkdir -p "$HOME/rust-g"
pushd "$HOME/rust-g"

if [ ! -d .git ]
then
	git init
	git remote add origin https://github.com/tgstation/rust-g.git
fi

git fetch origin --depth=1 $RUST_G_VERSION
git reset --hard FETCH_HEAD

rustup target add i686-unknown-linux-gnu

env PKG_CONFIG_ALLOW_CROSS=1 cargo build --release --target=i686-unknown-linux-gnu

mkdir -p ~/.byond/bin
cp target/i686-unknown-linux-gnu/release/librust_g.so  ~/.byond/bin/librust_g.so
chmod +x ~/.byond/bin/librust_g.so
ldd ~/.byond/bin/librust_g.so

popd
