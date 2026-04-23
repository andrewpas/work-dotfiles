#!/usr/bin/env bash
# Install ranger

set -e

if command -v ranger >/dev/null 2>&1; then
  exit 0
fi

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

echo "Installing ranger..."

case "$ID" in
  cachyos|arch|endeavouros|manjaro)
    sudo pacman -S --noconfirm ranger
    ;;
  ubuntu|debian|linuxmint|pop)
    sudo apt-get install -y ranger
    ;;
  ol|rhel|rocky|almalinux)
    sudo dnf install -y epel-release
    if ! sudo dnf install -y ranger 2>/dev/null; then
      # ranger може бути відсутній в EPEL — встановлюємо через pip
      sudo dnf install -y python3-pip
      pip3 install --user ranger-fm
    fi
    ;;
  fedora)
    sudo dnf install -y ranger
    ;;
  *)
    echo "Unknown distro '$ID', please install ranger manually." >&2
    exit 1
    ;;
esac
