#!/usr/bin/env bash
# Install tmux and Oh my tmux! framework

set -e

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

# --- tmux ---
if ! command -v tmux >/dev/null 2>&1; then
  echo "Installing tmux..."
  case "$ID" in
    cachyos|arch|endeavouros|manjaro)
      sudo pacman -S --noconfirm tmux ;;
    ubuntu|debian|linuxmint|pop)
      sudo apt-get install -y tmux ;;
    ol|rhel|rocky|almalinux)
      sudo dnf install -y epel-release
      sudo dnf install -y tmux ;;
    fedora)
      sudo dnf install -y tmux ;;
    *)
      echo "Unknown distro '$ID', please install tmux manually." >&2
      exit 1 ;;
  esac
fi

# --- Oh my tmux! ---
_omt_dir="$HOME/.local/share/tmux/oh-my-tmux"
_tmux_conf="$HOME/.config/tmux/tmux.conf"

if [[ ! -d "$_omt_dir" ]]; then
  echo "Installing Oh my tmux!..."
  git clone --depth 1 https://github.com/gpakosz/.tmux.git "$_omt_dir"
fi

# Symlink tmux.conf → Oh my tmux! main config
mkdir -p "$(dirname "$_tmux_conf")"
if [[ ! -L "$_tmux_conf" ]]; then
  ln -sf "$_omt_dir/.tmux.conf" "$_tmux_conf"
fi
