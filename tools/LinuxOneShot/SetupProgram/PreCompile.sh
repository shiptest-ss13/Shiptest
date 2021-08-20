#!/bin/bash

# REPO MAINTAINERS: KEEP CHANGES TO THIS IN SYNC WITH /tools/tgs4_scripts/PreCompile.sh

set -e
set -x

#load dep exports
#need to switch to game dir for Dockerfile weirdness
original_dir=$PWD
cd "$1"
. dependencies.sh
cd "$original_dir"

#find out what we have (+e is important for this)
set +e
has_git="$(command -v git)"
has_cargo="$(command -v ~/.cargo/bin/cargo)"
has_sudo="$(command -v sudo)"
has_grep="$(command -v grep)"
has_youtubedl="$(command -v youtube-dl)"
has_pip3="$(command -v pip3)"
DATABASE_EXISTS="$(mysqlshow --host mariadb --port 3306 --user=root --password=$MYSQL_ROOT_PASSWORD ss13_db| grep -v Wildcard | grep -o ss13_db)"
set -e

# install cargo if needed
if ! [ -x "$has_cargo" ]; then
	echo "Installing rust..."
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	. ~/.profile
fi

# apt packages, libssl needed by rust-g but not included in TGS barebones install
if ! ( [ -x "$has_git" ] && [ -x "$has_grep" ] && [ -f "/usr/lib/i386-linux-gnu/libssl.so" ] ); then
	echo "Installing apt dependencies..."
	if ! [ -x "$has_sudo" ]; then
		dpkg --add-architecture i386
		apt-get update
		apt-get install -y git libssl-dev:i386 grep mysql-client lib32z1 pkg-config libssl-dev
		rm -rf /var/lib/apt/lists/*
	else
		sudo dpkg --add-architecture i386
		sudo apt-get update
		sudo apt-get install -y git libssl-dev:i386 grep mysql-client lib32z1 pkg-config libssl-dev
		sudo rm -rf /var/lib/apt/lists/*
	fi
fi

dpkg --add-architecture i386
apt-get update
apt-get install -y lib32z1 pkg-config libssl-dev:i386 libssl-dev libssl1.1:i386

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
	git clone https://github.com/Putnam3145/auxmos
	cd auxmos
	~/.cargo/bin/rustup target add i686-unknown-linux-gnu
	cd ..
else
	echo "Fetching auxmos..."
	cd auxmos
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
env PKG_CONFIG_ALLOW_CROSS=1 RUSTFLAGS="-C target-cpu=native" ~/.cargo/bin/cargo build --release --target=i686-unknown-linux-gnu --features "all_reaction_hooks"
mv target/i686-unknown-linux-gnu/release/libauxmos.so "$1/libauxmos.so"
cd ..

# compile tgui
echo "Compiling tgui..."
cd "$1"
chmod +x tools/bootstrap/node  # Workaround for https://github.com/tgstation/tgstation-server/issues/1167
env TG_BOOTSTRAP_CACHE="$original_dir" TG_BOOTSTRAP_NODE_LINUX=1 TG_BUILD_TGS_MODE=1 tools/bootstrap/node tools/build/build.js
cd "$original_dir"

if [ ! -d "../GameStaticFiles/config" ]; then
	echo "Creating initial config..."
	cp -r "$1/config" "../GameStaticFiles/config"
	echo -e "SQL_ENABLED\nFEEDBACK_TABLEPREFIX SS13_\nADDRESS mariadb\nPORT 3306\nFEEDBACK_DATABASE ss13_db\nFEEDBACK_LOGIN root\nFEEDBACK_PASSWORD $MYSQL_ROOT_PASSWORD\nASYNC_QUERY_TIMEOUT 10\nBLOCKING_QUERY_TIMEOUT 5\nBSQL_THREAD_LIMIT 50" > "../GameStaticFiles/config/dbconfig.txt"
	echo "$TGS_ADMIN_CKEY = Host" > "../GameStaticFiles/config/admins.txt"
fi

if [ "$DATABASE_EXISTS" != "ss13_db" ]; then
	echo "Creating initial SS13 database..."
    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h mariadb -P 3306 -e 'CREATE DATABASE IF NOT EXISTS ss13_db;'
	cat "$1/$TGS_PREFIXED_SCHEMA_FILE"
    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h mariadb -P 3306 ss13_db < "$1/$TGS_PREFIXED_SCHEMA_FILE"
    mysql -u root --password=$MYSQL_ROOT_PASSWORD -h mariadb -P 3306 ss13_db -e "INSERT INTO \`SS13_schema_revision\` (\`major\`, \`minor\`) VALUES ($TGS_SCHEMA_MAJOR_VERSION, $TGS_SCHEMA_MINOR_VERSION)"
fi

# install or update youtube-dl when not present, or if it is present with pip3,
# which we assume was used to install it
if ! [ -x "$has_youtubedl" ]; then
	echo "Installing youtube-dl with pip3..."
	if ! [ -x "$has_sudo" ]; then
		apt-get install -y python3 python3-pip
	else
		sudo apt-get install -y python3 python3-pip
	fi
	pip3 install youtube-dl
elif [ -x "$has_pip3" ]; then
	echo "Ensuring youtube-dl is up-to-date with pip3..."
	pip3 install youtube-dl -U
fi

# compile tgui
echo "Compiling tgui..."
cd "$1"
chmod +x tools/bootstrap/node  # Workaround for https://github.com/tgstation/tgstation-server/issues/1167
chmod +x tgui/bin/tgui
env TG_BOOTSTRAP_CACHE="$original_dir" TG_BOOTSTRAP_NODE_LINUX=1 TG_BUILD_TGS_MODE=1 tools/bootstrap/node tools/build/build.js
