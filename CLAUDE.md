# CLAUDE.md — work-dotfiles

Цей репозиторій керує dotfiles через [chezmoi](https://chezmoi.io).
Джерело: `~/.local/share/chezmoi/` → цільова директорія: `~` (home).

## Структура репозиторію

```
.
├── dot_zshrc                          → ~/.zshrc
├── dot_config/
│   ├── alacritty/private_alacritty.toml → ~/.config/alacritty/alacritty.toml
│   ├── bat/config                     → ~/.config/bat/config
│   ├── nvim/                          → ~/.config/nvim/  (NvChad конфіг)
│   ├── tmux/tmux.conf.local           → ~/.config/tmux/tmux.conf.local
│   └── private_mc/
│       ├── ini                        → ~/.config/mc/ini
│       └── empty_panels.ini           → ~/.config/mc/panels.ini
├── dot_local/share/private_mc/skins/
│   └── gruvbox-dark-hard.ini          → ~/.local/share/mc/skins/gruvbox-dark-hard.ini
├── run_once_before_install-zsh.sh     # виконується першим
├── run_once_install-oh-my-zsh.sh
├── run_once_install-zsh-plugins.sh
├── run_once_install-tools.sh          # fzf, zoxide, atuin, linuxbrew
├── run_once_install-bat.sh
├── run_once_install-ranger.sh
├── run_once_install-nvim.sh
├── run_once_install-alacritty.sh
├── run_once_install-tmux.sh           # tmux + Oh my tmux!
├── run_once_install-mc.sh             # Midnight Commander
├── README.md                          # інструкція для нової машини
├── zsh.md / bat.md / nvim.md / mc.md / ...  # документація по кожному інструменту
└── CLAUDE.md                          # цей файл
```

## Угоди chezmoi

- `dot_` префікс → крапка у цільовому імені (`dot_zshrc` → `.zshrc`)
- `private_` префікс → файл з правами 600
- `run_once_` → виконується один раз (при першому `chezmoi apply`)
- `run_once_before_` → виконується до інших `run_once_` скриптів

## Підтримувані дистрибутиви

Всі `run_once_install-*.sh` скрипти визначають дистрибутив через `$ID` з `/etc/os-release`:

| `$ID` | Дистрибутив | Пакетний менеджер |
|---|---|---|
| `cachyos`, `arch`, `endeavouros`, `manjaro` | Arch-based | `pacman` |
| `ubuntu`, `debian`, `linuxmint`, `pop` | Debian-based | `apt` |
| `ol`, `rhel`, `rocky`, `almalinux` | RHEL-based | `dnf` + EPEL |
| `fedora` | Fedora | `dnf` |

## Як додати новий інструмент

1. Додати конфіг до chezmoi:
   ```bash
   chezmoi add ~/.config/<tool>/config
   ```
2. Створити `run_once_install-<tool>.sh` зі структурою `case "$ID" in ...`
3. Зробити скрипт виконуваним: `chmod +x run_once_install-<tool>.sh`
4. Створити `<tool>.md` з документацією (швидкий старт, дистрибутиви, конфіг)
5. Оновити таблицю в `README.md`
6. Закомітити і запушити

## Як оновити існуючий конфіг

```bash
chezmoi re-add ~/.config/<tool>/config
cd ~/.local/share/chezmoi
git add . && git commit -m "chore: update <tool> config" && git push
```

## Особливості окремих інструментів

- **tmux**: `tmux.conf` є симлінком на Oh my tmux! (`~/.local/share/tmux/oh-my-tmux/`). Редагувати лише `tmux.conf.local`.
- **nvim**: плагіни NvChad завантажуються lazy.nvim при першому запуску `nvim`.
- **tmux плагіни**: TPM встановлює їх автоматично при першому запуску `tmux`.
- **bat на Ubuntu**: бінарник називається `batcat` — скрипт створює симлінк `~/.local/bin/bat`.
- **nvim на Ubuntu/OL9**: встановлюється AppImage (apt/dnf версія < 0.10, потрібна NvChad).
- **alacritty на OL9**: збирається через `cargo` (відсутній в EPEL).
- **mc**: конфіг у `private_mc/` (права 700 на директорію). Скін gruvbox-dark-hard зберігається у `dot_local/share/private_mc/skins/` і деплоїться в `~/.local/share/mc/skins/`. Зовнішній редактор: nvim (`use_internal_edit=false`).
