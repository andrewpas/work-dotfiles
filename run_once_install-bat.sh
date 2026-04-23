#!/usr/bin/env bash
# Install bat

set -e

if command -v bat >/dev/null 2>&1; then
  exit 0
fi

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

echo "Installing bat..."

case "$ID" in
  cachyos|arch|endeavouros|manjaro)
    sudo pacman -S --noconfirm bat
    ;;
  ubuntu|debian|linuxmint|pop)
    sudo apt-get install -y bat
    # На Ubuntu бінарник називається batcat — робимо симлінк
    mkdir -p ~/.local/bin
    ln -sf /usr/bin/batcat ~/.local/bin/bat
    ;;
  ol|rhel|rocky|almalinux)
    sudo dnf install -y epel-release
    sudo dnf install -y bat
    ;;
  fedora)
    sudo dnf install -y bat
    ;;
  *)
    echo "Unknown distro '$ID', please install bat manually." >&2
    exit 1
    ;;
esac
