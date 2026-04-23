-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "gruvchad",
  statusline = {
    theme = "vscode_colored", -- Кольоровий стиль з блоками
    separator_style = "default",
  },
}

M.nvimtree = {
  view = {
    width = 40, -- Приблизно 25% від стандартної ширини екрану
  },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
