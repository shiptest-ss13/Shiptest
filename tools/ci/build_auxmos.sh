#!/bin/bash
set -euo pipefail

source dependencies.sh

mkdir -p "$HOME/auxmos"
cd "$HOME/auxmos"

if [ ! -d .git ]
then
	git init
	git remote add origin https://github.com/Putnam3145/auxmos.git
fi

git fetch origin --depth=1 $AUXMOS_VERSION
git reset --hard FETCH_HEAD

sudo apt-get install g++-multilib -y
rustup target add i686-unknown-linux-gnu

cargo build --release --target=i686-unknown-linux-gnu --features katmos
cp target/i686-unknown-linux-gnu/release/libauxmos.so  $GITHUB_WORKSPACE/libauxmos.so
ldd $GITHUB_WORKSPACE/libauxmos.so
