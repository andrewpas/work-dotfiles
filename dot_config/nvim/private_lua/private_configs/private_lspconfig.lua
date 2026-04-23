require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ansiblels",
  "bashls",
  "docker_compose_language_service",
  "dockerls",
  "sqls",
  "gitlab_ci_ls",
  "jqls",
  "jinja_lsp",
  "jsonls",
  "nginx_language_server",
  "pyright",
  "terraformls",
  "opentofu_ls",
  "yamlls",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
