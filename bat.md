# bat

`bat` — замінник `cat` з підсвічуванням синтаксису та інтеграцією з git.

## Що встановлюється

| Компонент | Розташування |
|---|---|
| бінарник `bat` | системний пакет |
| конфіг | `~/.config/bat/config` (керується через chezmoi) |

## Швидкий старт (нова машина)

```bash
# 1. Встановити chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

# 2. Застосувати dotfiles (встановить bat і конфіг)
chezmoi init --apply https://github.com/andrewpas/work-dotfiles.git
```

## Поточна конфігурація

- тема: `gruvbox-dark`
- стиль: `plain` (без нумерації рядків і рамок)

## Встановлення по дистрибутивах

| Дистрибутив | Метод |
|---|---|
| CachyOS / Arch | `pacman -S bat` |
| Ubuntu 24 / Debian | `apt install bat` + симлінк `batcat → bat` |
| Oracle Linux 9 / RHEL / Rocky | `dnf install epel-release && dnf install bat` |
| Fedora | `dnf install bat` |

> На Ubuntu бінарник називається `batcat` — скрипт автоматично створює симлінк `~/.local/bin/bat`.

## Оновлення конфігу

```bash
chezmoi re-add ~/.config/bat/config
cd ~/.local/share/chezmoi
git add dot_config/bat/config && git commit -m "chore: update bat config" && git push
```
