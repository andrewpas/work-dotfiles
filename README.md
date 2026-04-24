# work-dotfiles

Переносна конфігурація робочого середовища через [chezmoi](https://chezmoi.io).

## Що включено

| Інструмент | Конфіг | Документація |
|---|---|---|
| zsh + oh-my-zsh | `.zshrc` | [zsh.md](zsh.md) |
| tmux + Oh my tmux! | `tmux.conf.local` | [tmux.md](tmux.md) |
| Neovim + NvChad | `~/.config/nvim/` | [nvim.md](nvim.md) |
| Alacritty | `alacritty.toml` | [alacritty.md](alacritty.md) |
| bat | `~/.config/bat/config` | [bat.md](bat.md) |
| ranger | — | [ranger.md](ranger.md) |

## Розгортання на новій машині

### 1. Встановити chezmoi

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
```

### 2. Застосувати dotfiles

```bash
chezmoi init --apply https://github.com/andrewpas/work-dotfiles.git
```

Ця команда автоматично виконає всі bootstrap-скрипти в правильному порядку:

| Скрипт | Що робить |
|---|---|
| `run_once_before_install-zsh.sh` | встановлює zsh, робить його shell за замовчуванням |
| `run_once_install-oh-my-zsh.sh` | встановлює oh-my-zsh |
| `run_once_install-zsh-plugins.sh` | клонує zsh-syntax-highlighting, zsh-completions |
| `run_once_install-tools.sh` | встановлює fzf, zoxide, atuin, linuxbrew |
| `run_once_install-bat.sh` | встановлює bat |
| `run_once_install-ranger.sh` | встановлює ranger |
| `run_once_install-nvim.sh` | встановлює neovim ≥ 0.10 |
| `run_once_install-alacritty.sh` | встановлює alacritty |
| `run_once_install-tmux.sh` | встановлює tmux + Oh my tmux! |

### 3. Перезапустити shell

```bash
exec zsh
```

### 4. Перший запуск nvim

```bash
nvim
```

lazy.nvim автоматично завантажить всі плагіни NvChad.

### 5. Перший запуск tmux

```bash
tmux
```

TPM автоматично встановить всі плагіни tmux.

---

## Підтримувані дистрибутиви

| Дистрибутив | Пакетний менеджер |
|---|---|
| CachyOS / Arch / EndeavourOS / Manjaro | `pacman` |
| Ubuntu 24 / Debian / Pop!_OS / Mint | `apt` |
| Oracle Linux 9 / RHEL / Rocky / AlmaLinux / Fedora | `dnf` |

## Оновлення dotfiles на існуючій машині

```bash
chezmoi update
```

## Внесення змін до конфігу

Після редагування будь-якого конфіг-файлу напряму:

```bash
chezmoi re-add ~/.zshrc                          # або інший файл
cd ~/.local/share/chezmoi
git add . && git commit -m "chore: update config" && git push
```

Або через chezmoi:

```bash
chezmoi edit ~/.zshrc
chezmoi apply
```
