# Alacritty

Alacritty — швидкий GPU-прискорений термінальний емулятор.

## Що встановлюється

| Компонент | Розташування |
|---|---|
| бінарник `alacritty` | системний пакет / cargo |
| конфіг | `~/.config/alacritty/alacritty.toml` (керується через chezmoi) |

## Швидкий старт (нова машина)

```bash
# 1. Встановити chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

# 2. Застосувати dotfiles (встановить alacritty і конфіг)
chezmoi init --apply https://github.com/andrewpas/work-dotfiles.git
```

## Встановлення по дистрибутивах

| Дистрибутив | Метод |
|---|---|
| CachyOS / Arch | `pacman -S alacritty` |
| Ubuntu 24 / Debian | `apt install alacritty` |
| Oracle Linux 9 / RHEL / Rocky | `cargo install alacritty` (відсутній в EPEL) |
| Fedora | `dnf install alacritty` |

> На Oracle Linux 9 alacritty збирається з вихідного коду через cargo.
> Встановлення може зайняти кілька хвилин.

## Поточна конфігурація

- шрифт: `JetBrains Mono 10pt`
- тема: `Gruvbox Dark Hard`
- shell: `zsh`
- курсор: `Beam`, блимає кожні 500 мс
- вікно: максимізоване, padding 10px
- виділення автоматично копіюється в буфер обміну

## Клавіші

| Клавіші | Дія |
|---|---|
| `Alt+N` | нове вікно |
| `Ctrl+Shift+C` | копіювати |
| `Ctrl+Shift+V` | вставити |
| `Ctrl++` | збільшити шрифт |
| `Ctrl+-` | зменшити шрифт |
| `Ctrl+0` | скинути розмір шрифту |

## Оновлення конфігу

```bash
chezmoi re-add ~/.config/alacritty/alacritty.toml
cd ~/.local/share/chezmoi
git add dot_config/alacritty/ && git commit -m "chore: update alacritty config" && git push
```
