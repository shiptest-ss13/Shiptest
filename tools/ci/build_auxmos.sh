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

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libstdc++6:i386 gcc-multilib g++-7 g++-7-multilib zlib1g:i386 libssl1.1 libssl1.1:i386 -y
rustup target add i686-unknown-linux-gnu

env PKG_CONFIG_ALLOW_CROSS=1 cargo rustc --release --target=i686-unknown-linux-gnu --features "all_reaction_hooks,katmos"
cp target/i686-unknown-linux-gnu/release/libauxmos.so  ~/.byond/bin/libauxmos.so
chmod +x ~/.byond/bin/libauxmos.so
ldd ~/.byond/bin/libauxmos.so

popd
