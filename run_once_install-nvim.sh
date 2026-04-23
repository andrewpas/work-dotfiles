#!/usr/bin/env bash
# Install neovim >= 0.10 (required by NvChad)

set -e

if command -v nvim >/dev/null 2>&1; then
  exit 0
fi

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

echo "Installing neovim..."

_install_appimage() {
  mkdir -p ~/.local/bin
  local _dest="$HOME/.local/bin/nvim"
  curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage \
    -o "$_dest"
  chmod u+x "$_dest"

  # Якщо FUSE недоступний (типово для OL9/RHEL) — розпаковуємо AppImage
  if ! "$_dest" --version >/dev/null 2>&1; then
    local _extract_dir="$HOME/.local/share/nvim-appimage"
    "$_dest" --appimage-extract >/dev/null 2>&1
    mv squashfs-root "$_extract_dir"
    rm "$_dest"
    ln -sf "$_extract_dir/AppRun" "$_dest"
  fi
}

case "$ID" in
  cachyos|arch|endeavouros|manjaro)
    sudo pacman -S --noconfirm neovim
    ;;
  ubuntu|debian|linuxmint|pop)
    # apt-версія може бути < 0.10 — ставимо AppImage
    _install_appimage
    ;;
  ol|rhel|rocky|almalinux|fedora)
    # EPEL-версія може бути < 0.10 — ставимо AppImage
    _install_appimage
    ;;
  *)
    echo "Unknown distro '$ID', please install neovim manually." >&2
    exit 1
    ;;
esac
