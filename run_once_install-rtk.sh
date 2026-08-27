#!/usr/bin/env bash
# Install rtk (Rust Token Killer) + hook для Claude Code
# https://github.com/rtk-ai/rtk

set -e

# Увага: цей скрипт виконується ДО run_once_install-tools.sh (алфавітний порядок),
# тому brew на новій машині ще недоступний — основний шлях це офіційний install.sh.

if command -v rtk >/dev/null 2>&1 && rtk gain >/dev/null 2>&1; then
  echo "rtk вже встановлено ($(rtk --version))"
else
  echo "Installing rtk..."

  if command -v brew >/dev/null 2>&1; then
    brew install rtk
  else
    # Офіційний скрипт — встановлює в ~/.local/bin, працює на всіх дистрибутивах
    curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
  fi
fi

export PATH="$HOME/.local/bin:$PATH"

if ! command -v rtk >/dev/null 2>&1; then
  echo "rtk не потрапив у PATH, пропускаю налаштування хука." >&2
  exit 0
fi

# Деякі фільтри rtk викликають ripgrep
if ! command -v rg >/dev/null 2>&1; then
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
  fi
  echo "Installing ripgrep (потрібен для фільтрів rtk)..."
  case "$ID" in
    cachyos|arch|endeavouros|manjaro)
      sudo pacman -S --noconfirm ripgrep ;;
    ubuntu|debian|linuxmint|pop)
      sudo apt-get install -y ripgrep ;;
    ol|rhel|rocky|almalinux)
      sudo dnf install -y epel-release
      sudo dnf install -y ripgrep ;;
    fedora)
      sudo dnf install -y ripgrep ;;
    *)
      echo "Unknown distro '$ID', встановіть ripgrep вручну." >&2 ;;
  esac
fi

# Хук для Claude Code: PreToolUse на Bash, прозоро переписує команди в rtk-еквіваленти.
# --auto-patch = без інтерактивних запитів (телеметрія лишається вимкненою за замовчуванням).
if [[ -d "$HOME/.claude" ]]; then
  echo "Configuring rtk hook for Claude Code..."
  rtk init -g --auto-patch
  rtk init --show
else
  echo "~/.claude не знайдено — пропускаю налаштування хука."
  echo "Після встановлення Claude Code виконайте: rtk init -g"
fi
