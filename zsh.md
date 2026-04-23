# Налаштування Zsh через chezmoi

## Що встановлюється

| Компонент | Метод |
|---|---|
| zsh | пакетний менеджер системи |
| oh-my-zsh | офіційний install script |
| zsh-syntax-highlighting | git clone в `$ZSH_CUSTOM/plugins` |
| zsh-completions | git clone в `$ZSH_CUSTOM/plugins` |
| `.zshrc` | керується через chezmoi |

## Швидкий старт (нова машина)

```bash
# 1. Встановити chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

# 2. Застосувати dotfiles (встановить zsh, oh-my-zsh, плагіни, .zshrc)
chezmoi init --apply https://github.com/andrewpas/work-dotfiles.git

# 3. Перезапустити shell
exec zsh
```

> chezmoi виконує bootstrap скрипти автоматично в правильному порядку:
> 1. `run_once_before_install-zsh.sh` — встановлює zsh і робить його shell за замовчуванням
> 2. `run_once_install-oh-my-zsh.sh` — встановлює oh-my-zsh
> 3. `run_once_install-zsh-plugins.sh` — клонує кастомні плагіни

## Підтримувані дистрибутиви

| Дистрибутив | Пакетний менеджер |
|---|---|
| CachyOS / Arch / EndeavourOS / Manjaro | `pacman` |
| Ubuntu 24 / Debian / Pop!_OS / Mint | `apt` |
| Oracle Linux 9 / RHEL / Rocky / AlmaLinux / Fedora | `dnf` |

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
