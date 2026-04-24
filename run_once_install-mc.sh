#!/usr/bin/env bash
# Install Midnight Commander

set -e

if command -v mc >/dev/null 2>&1; then
  exit 0
fi

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

echo "Installing mc..."

case "$ID" in
  cachyos|arch|endeavouros|manjaro)
    sudo pacman -S --noconfirm mc
    ;;
  ubuntu|debian|linuxmint|pop)
    sudo apt-get install -y mc
    ;;
  ol|rhel|rocky|almalinux)
    sudo dnf install -y epel-release
    sudo dnf install -y mc
    ;;
  fedora)
    sudo dnf install -y mc
    ;;
  *)
    echo "Unknown distro '$ID', please install mc manually." >&2
    exit 1
    ;;
esac
