# rtk (Rust Token Killer)

`rtk` — CLI-проксі, який фільтрує й стискає вивід команд перед тим, як його прочитає
LLM-агент (Claude Code). Скорочує вивід bash на 60–90%.

Репозиторій: [github.com/rtk-ai/rtk](https://github.com/rtk-ai/rtk)

## Що встановлюється

| Компонент | Розташування |
|---|---|
| бінарник `rtk` | `~/.local/bin/rtk` (або brew) |
| конфіг | `~/.config/rtk/config.toml` (генерується самим rtk) |
| інструкції для агента | `~/.claude/RTK.md` + `@RTK.md` у `~/.claude/CLAUDE.md` |
| хук | `PreToolUse` → `rtk hook claude` у `~/.claude/settings.json` |
| логи повного виводу | `~/.local/share/rtk/tee/` |

> Конфіг rtk **не** керується через chezmoi — він машинозалежний і створюється автоматично.

## Швидкий старт (нова машина)

```bash
# 1. Встановити chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin

# 2. Застосувати dotfiles (встановить rtk + налаштує хук)
chezmoi init --apply https://github.com/andrewpas/work-dotfiles.git

# 3. Перезапустити Claude Code — хук активується лише після рестарту
```

## Як це працює

Хук `PreToolUse` перехоплює кожну Bash-команду і прозоро переписує її в rtk-еквівалент:

```
git status      →  rtk git status
cat file.md     →  rtk read file.md
grep -rn foo .  →  rtk grep -rn foo .
ls -la          →  rtk ls -la
npm run build   →  rtk npm run build
```

Ані користувач, ані агент не пишуть `rtk` вручну — переписування коштує 0 токенів.

**Що хук НЕ перехоплює:**

- вбудовані інструменти Claude Code (Read, Grep, Glob) — вони не Bash;
- багаторядкові скрипти та heredoc;
- команди зі списку `exclude_commands` у конфізі.

## Перевірка встановлення

```bash
rtk --version      # має показати: rtk X.Y.Z
rtk gain           # має працювати (не «command not found»)
rtk init --show    # статус хука, RTK.md, settings.json
which rtk
```

> **Колізія імен:** якщо `rtk gain` не працює — можливо, встановлено
> reachingforthejack/rtk (Rust Type Kit) замість цього.

## Аналітика

```bash
rtk gain              # зведення заощаджених токенів
rtk gain --graph      # ASCII-графік за 30 днів
rtk gain --history    # історія команд
rtk discover          # які команди пройшли повз rtk і скільки це коштувало
rtk session           # рівень адаптації rtk по сесіях Claude Code
rtk cc-economics      # витрати (ccusage) проти заощаджень (rtk)
```

## Корисні команди без нативного аналога

Ці команди хук не підставить автоматично — їх треба звати явно:

| Команда | Що робить |
|---|---|
| `rtk read file.rs -l aggressive` | лише сигнатури, без тіл функцій |
| `rtk smart file.rs` | 2-рядкове резюме файлу |
| `rtk json config.json --keys-only` | структура JSON без значень |
| `rtk err <cmd>` | лише помилки й попередження |
| `rtk test <cmd>` | лише падіння тестів |
| `rtk deps` | зведення залежностей проєкту |
| `rtk summary <cmd>` | евристичне резюме довгого виводу |
| `rtk proxy <cmd>` | сирий вивід без фільтрації (для дебагу) |

> `rtk read` за замовчуванням працює в режимі `-l none` — тобто **повний вміст без втрат**.
> Фільтрація вмикається лише явним `-l minimal|aggressive`.

## Конфігурація

`~/.config/rtk/config.toml`:

```toml
[tee]
enabled = true
mode = "failures"        # при падінні команди повний вивід зберігається у файл

[hooks]
exclude_commands = []    # команди, які хук не переписує

[telemetry]
enabled = false          # вимкнена; вмикається лише явним rtk telemetry enable
```

Телеметрія за замовчуванням **вимкнена** і потребує явної згоди. Жорстке блокування:

```bash
export RTK_TELEMETRY_DISABLED=1
```

## Встановлення по дистрибутивах

| Дистрибутив | Метод |
|---|---|
| Усі (основний шлях) | офіційний `install.sh` → `~/.local/bin` |
| Якщо є linuxbrew | `brew install rtk` |

Додатково скрипт ставить `ripgrep` — деякі фільтри rtk викликають `rg`.

> `run_once_install-rtk.sh` виконується **до** `run_once_install-tools.sh`
> (алфавітний порядок), тому на новій машині brew ще недоступний і спрацьовує `install.sh`.

## Видалення

```bash
rtk init -g --uninstall   # прибрати хук, RTK.md, запис у settings.json
brew uninstall rtk        # якщо ставилось через brew
```
