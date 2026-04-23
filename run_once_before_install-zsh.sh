#!/usr/bin/env bash
# Install zsh if not present
if command -v zsh >/dev/null 2>&1; then
  exit 0
fi

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

case "$ID" in
  cachyos|arch|endeavouros|manjaro)
    sudo pacman -S --noconfirm zsh
    ;;
  ubuntu|debian|linuxmint|pop)
    sudo apt-get update -qq && sudo apt-get install -y zsh
    ;;
  ol|rhel|centos|fedora|rocky|almalinux)
    sudo dnf install -y zsh
    ;;
  *)
    echo "Unknown distro '$ID', please install zsh manually." >&2
    exit 1
    ;;
esac

# Set zsh as default shell if it isn't already
if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  sudo chsh -s "$(command -v zsh)" "$USER"
fi
