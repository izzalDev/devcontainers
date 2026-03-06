#!/bin/sh
set -e

echo "Activating feature 'neovim'"

VERSION=${VERSION:-stable}
ARCH=$(uname -m | sed -e 's/aarch64/arm64/')

if ! command -v curl >/dev/null 2>&1; then
	echo "curl not found, attempting to install with apt..."
	apt-get update && apt-get install -y curl
fi

echo "Installing version: $VERSION"

STABLE_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$ARCH.tar.gz"
NIGHTLY_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-$ARCH.tar.gz"

case $VERSION in
stable)
	URL=$STABLE_URL
	;;
nightly)
	URL=$NIGHTLY_URL
	;;
v*)
	URL="https://github.com/neovim/neovim/releases/download/$VERSION/nvim-linux-$ARCH.tar.gz"
	;;
*)
	echo "Unknown version: $VERSION" >&2
	exit 1
	;;
esac

curl -LO $URL
tar -C /usr -xzf nvim-linux-$ARCH.tar.gz --strip-components=1
rm nvim-linux-$ARCH.tar.gz
