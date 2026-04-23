local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    python = { "isort", "black" },
    json = { "prettier" },
    yaml = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    markdown = { "prettier" },
    sql = { "sql_formatter" },
    terraform = { "terraform_fmt" },
    tofu = { "opentofu_fmt" },
    jinja = { "djlint" },
    jq = { "jq" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
