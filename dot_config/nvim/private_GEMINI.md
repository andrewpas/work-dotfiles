# GEMINI.md

## Project Overview

This is a **Neovim configuration** repository based on **NvChad v2.5**. It uses **Lua** for configuration and **lazy.nvim** for plugin management. The configuration follows the NvChad starter structure, allowing for easy customization while leveraging NvChad's pre-configured modules.

### Technologies
- **Editor:** [Neovim](https://neovim.io/)
- **Configuration Framework:** [NvChad v2.5](https://nvchad.com/)
- **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Language:** [Lua](https://www.lua.org/)
- **Key Plugins:** `nvim-lspconfig`, `conform.nvim` (formatting), `base46` (theming).

---

## Directory Structure

- `init.lua`: The main entry point. Bootstraps `lazy.nvim`, loads NvChad, and initializes user configurations.
- `lua/`: Contains all custom Lua configuration files.
    - `chadrc.lua`: The main configuration file for NvChad-specific settings (e.g., UI, themes).
    - `options.lua`: Standard Neovim options (requires `nvchad.options` as a base).
    - `mappings.lua`: Custom key mappings (requires `nvchad.mappings` as a base).
    - `autocmds.lua`: Custom autocommands (requires `nvchad.autocmds` as a base).
    - `plugins/`:
        - `init.lua`: Defines additional plugins to be loaded by `lazy.nvim`.
    - `configs/`: Contains configuration files for specific plugins (e.g., `lspconfig.lua`, `conform.lua`).

---

## Building and Running

### Prerequisites
- Neovim (v0.9.0 or higher recommended).
- A C compiler and `make` for some plugins to build.
- `stylua` for Lua formatting (optional).

### Commands
- **Launch Neovim:** Simply run `nvim` in your terminal.
- **Manage Plugins:** Use `:Lazy` within Neovim to open the lazy.nvim dashboard (sync, update, install plugins).
- **Update NvChad:** NvChad core is managed as a plugin via lazy.nvim.

---

## Development Conventions

1.  **NvChad Integration:** Most configuration files (`options.lua`, `mappings.lua`, etc.) should start by requiring the corresponding NvChad module (`require "nvchad.options"`) and then adding custom overrides.
2.  **Plugin Configuration:** New plugins should be added to `lua/plugins/init.lua`. For complex plugin configurations, create a separate file in `lua/configs/` and require it within the plugin's `opts` or `config` function.
3.  **Theming:** UI and theme settings are managed in `lua/chadrc.lua`. The default theme is `gruvchad`.
4.  **Formatting:** `conform.nvim` is used for formatting. Currently, `stylua` is configured for Lua.
5.  **LSP:** LSP servers are configured in `lua/configs/lspconfig.lua`. It uses NvChad's default LSP setup and adds additional servers as needed.

---

## Важливі правила
- **Keymaps Documentation:** Завжди оновлюй файл `keymaps.md` при додаванні нових гарячих клавіш або при поясненні існуючих операційних команд.
