#!/bin/bash
set -euo pipefail

source dependencies.sh

mkdir -p "$HOME/SpacemanDMM"
cd "$HOME/SpacemanDMM"

if [ ! -d .git ]
then
	git init
	git remote add origin https://github.com/SpaceManiac/SpacemanDMM.git
fi

git fetch origin --depth=1 $SPACEMAN_DMM_VERSION
git reset --hard FETCH_HEAD

cargo build --release --bin $1
cp target/release/$1 ~
~/$1 --version
