# Neovim + NvChad

Neovim з конфігурацією на базі [NvChad](https://nvchad.com/).

## Що встановлюється і відновлюється

| Компонент | Метод |
|---|---|
| neovim | системний пакет або AppImage |
| конфіг `~/.config/nvim/` | керується через chezmoi |
| плагіни | lazy.nvim завантажує автоматично при першому запуску |

## Встановлення по дистрибутивах

| Дистрибутив | Метод | Примітка |
|---|---|---|
| CachyOS / Arch | `pacman -S neovim` | актуальна версія в репо |
| Ubuntu 24 / Debian | AppImage з GitHub releases | apt-версія може бути < 0.10 |
| Oracle Linux 9 / RHEL / Rocky / Fedora | AppImage з GitHub releases | EPEL-версія може бути < 0.10 |

> NvChad потребує neovim >= 0.10. На Ubuntu і OL9 встановлюється AppImage в `~/.local/bin/nvim`.
> Якщо на системі немає FUSE — AppImage розпаковується в `~/.local/share/nvim-appimage/`.

## Швидкий старт на новій машині

```bash
# chezmoi відновить ~/.config/nvim/ автоматично
chezmoi init --apply https://github.com/andrewpas/work-dotfiles.git

# Перший запуск — lazy.nvim встановить всі плагіни
nvim
```

## Структура конфігу

```
~/.config/nvim/
├── init.lua              # точка входу
├── lazy-lock.json        # зафіксовані версії плагінів
└── lua/
    ├── chadrc.lua        # налаштування NvChad
    ├── options.lua       # vim опції
    ├── mappings.lua      # клавіші
    ├── autocmds.lua      # автокоманди
    ├── configs/
    │   ├── lazy.lua      # налаштування lazy.nvim
    │   ├── lspconfig.lua # LSP сервери
    │   └── conform.lua   # форматування
    └── plugins/
        └── init.lua      # список плагінів
```

## Оновлення конфігу

```bash
chezmoi re-add ~/.config/nvim/
cd ~/.local/share/chezmoi
git add dot_config/nvim/ && git commit -m "chore: update nvim config" && git push
```
