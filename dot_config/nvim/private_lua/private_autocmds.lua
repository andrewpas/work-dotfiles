require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/tasks/*.{yml,yaml}",
    "*/handlers/*.{yml,yaml}",
    "*/vars/*.{yml,yaml}",
    "*/defaults/*.{yml,yaml}",
    "*/meta/*.{yml,yaml}",
    "site.{yml,yaml}",
    "playbook.{yml,yaml}",
    "main.{yml,yaml}",
  },
  callback = function()
    vim.bo.filetype = "yaml.ansible"
  end,
})
