# ranger

`ranger` — консольний файловий менеджер з vim-клавіатурою.

## Встановлення по дистрибутивах

| Дистрибутив | Метод |
|---|---|
| CachyOS / Arch | `pacman -S ranger` |
| Ubuntu 24 / Debian | `apt install ranger` |
| Oracle Linux 9 / RHEL / Rocky | `dnf install epel-release && dnf install ranger`, або `pip3 install ranger-fm` |
| Fedora | `dnf install ranger` |

> На Oracle Linux 9 ranger може бути відсутній в EPEL — скрипт автоматично падає на `pip3 install ranger-fm`.

## Генерація конфігу (після встановлення)

За замовчуванням ranger не створює конфіг-файли. Щоб отримати їх для кастомізації:

```bash
ranger --copy-config=all
# Файли з'являться в ~/.config/ranger/
```

## Основні клавіші

| Клавіша | Дія |
|---|---|
| `h/j/k/l` | навігація |
| `Enter` | відкрити файл / зайти в директорію |
| `q` | вийти |
| `yy` | копіювати файл |
| `dd` | вирізати файл |
| `pp` | вставити |
| `zh` | показати/сховати приховані файли |
| `S` | відкрити shell в поточній директорії |
