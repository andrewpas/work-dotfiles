# Налаштування Zsh через chezmoi

## Що встановлюється

| Компонент | Метод |
|---|---|
| zsh | пакетний менеджер системи |
| oh-my-zsh | офіційний install script |
| zsh-syntax-highlighting | git clone в `$ZSH_CUSTOM/plugins` |
| zsh-completions | git clone в `$ZSH_CUSTOM/plugins` |
| fzf | пакетний менеджер / git clone (OL9) |
| zoxide | пакетний менеджер / curl-скрипт |
| atuin | пакетний менеджер / curl-скрипт |
| linuxbrew | офіційний install script |
| `.zshrc` | керується через chezmoi |

## Швидкий старт (нова машина)

```bash
# 1. Встановити chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

# 2. Застосувати dotfiles
chezmoi init --apply https://github.com/andrewpas/work-dotfiles.git

# 3. Перезапустити shell
exec zsh
```

> chezmoi виконує bootstrap скрипти автоматично в правильному порядку:
> 1. `run_once_before_install-zsh.sh` — встановлює zsh і робить його shell за замовчуванням
> 2. `run_once_install-oh-my-zsh.sh` — встановлює oh-my-zsh
> 3. `run_once_install-zsh-plugins.sh` — клонує кастомні плагіни
> 4. `run_once_install-tools.sh` — встановлює fzf, zoxide, atuin, linuxbrew

## Підтримувані дистрибутиви

| Дистрибутив | Пакетний менеджер |
|---|---|
| CachyOS / Arch / EndeavourOS / Manjaro | `pacman` |
| Ubuntu 24 / Debian / Pop!_OS / Mint | `apt` |
| Oracle Linux 9 / RHEL / Rocky / AlmaLinux / Fedora | `dnf` |

### Особливості встановлення інструментів по дистрибутивах

| Інструмент | CachyOS/Arch | Ubuntu 24 | Oracle Linux 9 / RHEL |
|---|---|---|---|
| fzf | pacman | apt | git clone + symlink в `~/.local/bin` |
| zoxide | pacman | apt | офіційний curl-скрипт |
| atuin | pacman | офіційний curl-скрипт | офіційний curl-скрипт |
| linuxbrew | офіційний скрипт | офіційний скрипт | офіційний скрипт |

## Оновлення .zshrc

Редагувати напряму, потім синхронізувати з chezmoi:

```bash
chezmoi re-add ~/.zshrc
cd ~/.local/share/chezmoi
git add dot_zshrc && git commit -m "chore: update .zshrc" && git push
```

Або редагувати через chezmoi:

```bash
chezmoi edit ~/.zshrc
chezmoi apply
```

## Отримати оновлення на існуючій машині

```bash
chezmoi update
```
