#!/usr/bin/env bash
# Install external tools: fzf, zoxide, atuin, linuxbrew

set -e

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
fi

pacman_install() { sudo pacman -S --noconfirm "$@"; }
apt_install()    { sudo apt-get install -y "$@"; }
dnf_install()    { sudo dnf install -y "$@"; }

# --- fzf ---
if ! command -v fzf >/dev/null 2>&1; then
  echo "Installing fzf..."
  case "$ID" in
    cachyos|arch|endeavouros|manjaro)
      pacman_install fzf ;;
    ubuntu|debian|linuxmint|pop)
      apt_install fzf ;;
    ol|rhel|rocky|almalinux)
      # fzf не в стандартних репозиторіях OL9 — встановлюємо з git
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
      ~/.fzf/install --all --no-bash --no-fish --no-zsh
      # бінарник кладемо в ~/.local/bin для доступності
      ln -sf ~/.fzf/bin/fzf ~/.local/bin/fzf
      ;;
    fedora)
      dnf_install fzf ;;
  esac
fi

# --- zoxide ---
if ! command -v zoxide >/dev/null 2>&1; then
  echo "Installing zoxide..."
  case "$ID" in
    cachyos|arch|endeavouros|manjaro)
      pacman_install zoxide ;;
    ubuntu|debian|linuxmint|pop)
      apt_install zoxide ;;
    ol|rhel|rocky|almalinux|fedora|*)
      # Офіційний скрипт — встановлює в ~/.local/bin
      curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
      ;;
  esac
fi

# --- atuin ---
if ! command -v atuin >/dev/null 2>&1; then
  echo "Installing atuin..."
  case "$ID" in
    cachyos|arch|endeavouros|manjaro)
      pacman_install atuin ;;
    *)
      # Офіційний скрипт працює на всіх дистрибутивах
      bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
      ;;
  esac
fi

# --- linuxbrew ---
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing linuxbrew..."

  # Встановлення залежностей
  case "$ID" in
    cachyos|arch|endeavouros|manjaro)
      pacman_install --needed base-devel curl git ;;
    ubuntu|debian|linuxmint|pop)
      apt_install build-essential procps curl file git ;;
    ol|rhel|rocky|almalinux)
      sudo dnf groupinstall -y 'Development Tools'
      dnf_install curl file git ;;
    fedora)
      sudo dnf groupinstall -y 'Development Tools'
      dnf_install curl file git ;;
  esac

  # Встановлюємо в /home/linuxbrew/.linuxbrew (системний шлях як в .zshrc)
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
