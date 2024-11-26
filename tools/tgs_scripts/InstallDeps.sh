#!/bin/bash

#find out what we have (+e is important for this)
set +e
has_git="$(command -v git)"
has_cargo="$(command -v ~/.cargo/bin/cargo)"
has_sudo="$(command -v sudo)"
has_curl="$(command -v curl)"
has_grep="$(command -v grep)"
has_pip3="$(command -v pip3)"
set -e
set -x

# apt packages, libssl needed by rust-g but not included in TGS barebones install
if ! ( [ -x "$has_git" ] && [ -x "$has_grep" ]  && [ -x "$has_curl" ] && [ -f "/usr/lib/i386-linux-gnu/libssl.so" ] ); then
	echo "Installing apt dependencies..."
	if ! [ -x "$has_sudo" ]; then
		dpkg --add-architecture i386
		apt-get update
		apt-get install -y build-essential clang g++-multilib libc6-i386 libstdc++6:i386 lib32z1 git pkg-config libssl-dev:i386 libssl-dev zlib1g-dev:i386 curl grep
	else
		sudo dpkg --add-architecture i386
		sudo apt-get update
		sudo apt-get install -y build-essential clang g++-multilib libc6-i386 libstdc++6:i386 lib32z1 git pkg-config libssl-dev:i386 libssl-dev zlib1g-dev:i386 curl grep
	fi
fi

# install cargo if needed
if ! [ -x "$has_cargo" ]; then
	echo "Installing rust..."
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	. ~/.profile
fi

# install or update yt-dlp when not present
echo "Installing/updating yt-dlp..."
if ! [ -x "$has_sudo" ]; then
	apt-get update
	apt-get install -y yt-dlp
else
	sudo apt-get update
	sudo apt-get install -y yt-dlp
fi


