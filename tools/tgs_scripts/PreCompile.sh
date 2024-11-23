#!/bin/bash

./InstallDeps.sh

set -e
set -x

#load dep exports
#need to switch to game dir for Dockerfile weirdness
original_dir=$PWD
cd "$1"
. dependencies.sh
cd "$original_dir"

# update rust-g
if [ ! -d "rust-g" ]; then
	echo "Cloning rust-g..."
	git clone https://github.com/tgstation/rust-g
	cd rust-g
	~/.cargo/bin/rustup target add i686-unknown-linux-gnu
	cd ..
else
	echo "Fetching rust-g..."
	cd rust-g
	git fetch
	~/.cargo/bin/rustup target add i686-unknown-linux-gnu
	cd ..
fi

# update auxmos
if [ ! -d "auxmos" ]; then
	echo "Cloning auxmos..."
	git clone "$AUXMOS_REPO"
	cd auxmos
	~/.cargo/bin/rustup target add i686-unknown-linux-gnu
	cd ..
else
	echo "Fetching auxmos..."
	cd auxmos
	git remote set-url origin "$AUXMOS_REPO"
	git fetch
	~/.cargo/bin/rustup target add i686-unknown-linux-gnu
	cd ..
fi

echo "Deploying rust-g..."
cd rust-g
git checkout "$RUST_G_VERSION"
env PKG_CONFIG_ALLOW_CROSS=1 RUSTFLAGS="-C target-cpu=native" ~/.cargo/bin/cargo build --release --target=i686-unknown-linux-gnu
mv target/i686-unknown-linux-gnu/release/librust_g.so "$1/librust_g.so"
cd ..

echo "Deploying auxmos..."
cd auxmos
git checkout "$AUXMOS_VERSION"
env PKG_CONFIG_ALLOW_CROSS=1 RUSTFLAGS="-C target-cpu=native" ~/.cargo/bin/cargo build --release --target=i686-unknown-linux-gnu --features "citadel_reactions,katmos"
mv target/i686-unknown-linux-gnu/release/libauxmos.so "$1/libauxmos.so"
cd ..

# compile tgui
echo "Compiling tgui..."
cd "$1"
env TG_BOOTSTRAP_CACHE="$original_dir" TG_BOOTSTRAP_NODE_LINUX=1 CBT_BUILD_MODE="TGS" tools/bootstrap/node tools/build/build.js
