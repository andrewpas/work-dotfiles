# Midnight Commander (mc)

Двопанельний файловий менеджер для термінала.

## Швидкий старт

| Клавіша | Дія |
|---|---|
| `Tab` | Переключення між панелями |
| `F3` | Перегляд файлу (вбудований viewer) |
| `F4` | Редагування файлу (зовнішній редактор) |
| `F5` | Копіювати |
| `F6` | Перемістити / перейменувати |
| `F7` | Створити директорію |
| `F8` | Видалити |
| `F9` | Меню |
| `F10` | Вийти |
| `Ctrl+O` | Сховати панелі / показати shell |
| `Ctrl+R` | Оновити панель |
| `Ctrl+S` | Швидкий пошук по імені файлу |
| `Alt+.` | Показати/сховати приховані файли |

## Конфіг

| Файл | Призначення |
|---|---|
| `~/.config/mc/ini` | Основні налаштування, скін |
| `~/.config/mc/panels.ini` | Налаштування панелей |
| `~/.local/share/mc/skins/gruvbox-dark-hard.ini` | Тема gruvbox-dark-hard |

Активна тема: **gruvbox-dark-hard** (`skin=gruvbox-dark-hard` в `ini`).

Зовнішній редактор: `use_internal_edit=false` → використовується `$EDITOR` / `$VISUAL` (nvim).

## Підтримувані дистрибутиви

| Дистрибутив | Команда |
|---|---|
| Arch / Manjaro / CachyOS | `pacman -S mc` |
| Ubuntu / Debian | `apt install mc` |
| RHEL / OL9 / Rocky | `dnf install epel-release && dnf install mc` |
| Fedora | `dnf install mc` |
