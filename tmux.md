# tmux

tmux з фреймворком [Oh my tmux!](https://github.com/gpakosz/.tmux) та плагінами через TPM.

## Що встановлюється і відновлюється

| Компонент | Метод |
|---|---|
| tmux | системний пакет |
| Oh my tmux! | git clone в `~/.local/share/tmux/oh-my-tmux/` |
| `tmux.conf` | симлінк → Oh my tmux! |
| `tmux.conf.local` | керується через chezmoi |
| TPM + плагіни | автоматично при першому запуску tmux |

## Швидкий старт (нова машина)

```bash
# 1. Встановити chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

# 2. Застосувати dotfiles (встановить tmux, Oh my tmux!, tmux.conf.local)
chezmoi init --apply https://github.com/andrewpas/work-dotfiles.git

# 3. Запустити tmux — TPM автоматично встановить плагіни
tmux
```

> При першому запуску tmux автоматично встановлює TPM та всі плагіни
> (оскільки `tmux_conf_update_plugins_on_launch=true`).

## Встановлення по дистрибутивах

| Дистрибутив | Метод |
|---|---|
| CachyOS / Arch | `pacman -S tmux` |
| Ubuntu 24 / Debian | `apt install tmux` |
| Oracle Linux 9 / RHEL / Rocky | `dnf install epel-release && dnf install tmux` |
| Fedora | `dnf install tmux` |

## Плагіни

| Плагін | Призначення |
|---|---|
| `egel/tmux-gruvbox` | тема Gruvbox Dark |
| `sainnhe/tmux-fzf` | fzf інтеграція |
| `jaclu/tmux-menus` | контекстні меню |

## Структура конфігу

```
~/.config/tmux/
├── tmux.conf        → симлінк на Oh my tmux! (не редагувати)
└── tmux.conf.local  ← всі кастомізації тут
```

## Поточна конфігурація

- тема: Oh my tmux! з Gruvbox Dark overlay
- mouse: увімкнено
- history-limit: 10000
- копіювання в системний буфер: увімкнено
- TPM: автооновлення при запуску та перезавантаженні конфігу

## Оновлення конфігу

```bash
chezmoi re-add ~/.config/tmux/tmux.conf.local
cd ~/.local/share/chezmoi
git add dot_config/tmux/ && git commit -m "chore: update tmux config" && git push
```

## Корисні клавіші (Oh my tmux!)

| Клавіші | Дія |
|---|---|
| `Ctrl+b` | prefix |
| `prefix + -` | розділити вертикально |
| `prefix + _` | розділити горизонтально |
| `prefix + h/j/k/l` | переміщення між панелями |
| `prefix + m` | увімкнути/вимкнути mouse |
| `prefix + I` | встановити плагіни (TPM) |
| `prefix + u` | оновити плагіни (TPM) |
| `prefix + e` | відкрити tmux.conf.local |
| `prefix + r` | перезавантажити конфіг |
