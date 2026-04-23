#!/usr/bin/env bash
# Install alacritty

set -e

if command -v alacritty >/dev/null 2>&1; then
  exit 0
fi

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

echo "Installing alacritty..."

case "$ID" in
  cachyos|arch|endeavouros|manjaro)
    sudo pacman -S --noconfirm alacritty
    ;;
  ubuntu|debian|linuxmint|pop)
    sudo apt-get install -y alacritty
    ;;
  ol|rhel|rocky|almalinux)
    # Alacritty відсутній в EPEL — встановлюємо через cargo
    sudo dnf install -y epel-release
    sudo dnf install -y cargo cmake freetype-devel fontconfig-devel \
      libxcb-devel libxkbcommon-devel g++
    cargo install alacritty
    mkdir -p ~/.local/bin
    ln -sf ~/.cargo/bin/alacritty ~/.local/bin/alacritty
    ;;
  fedora)
    sudo dnf install -y alacritty
    ;;
  *)
    echo "Unknown distro '$ID', please install alacritty manually." >&2
    exit 1
    ;;
esac
