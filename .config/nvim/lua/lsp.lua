local lsp = vim.lsp

lsp.log.set_level(vim.log.levels.OFF)
lsp.log.set_level(vim.log.levels.OFF)

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = true },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
  },
})

lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

local lsp_dir = vim.fn.stdpath('config') .. '/lsp'
local servers = {}

if vim.fn.isdirectory(lsp_dir) == 1 then
  local lsp_files = vim.fn.glob(lsp_dir .. '/*.lua', false, true)
  for _, file in ipairs(lsp_files) do
    local server_name = vim.fn.fnamemodify(file, ':t:r')
    table.insert(servers, server_name)
  end
end

local default_servers = {
  'astro',
  'dockerls',
  'docker_compose_language_service',
  'rust_analyzer',
  'gopls',
  'fish_lsp',
  'qmlls',
  'bashls',
  'emmet_language_server',
  'taplo',
  'eslint',
  'prismals',
  'cssls',
  'css_variables',
  'cssmodules_ls',
  'postgres_lsp',
  'marksman',
}

for _, name in ipairs(default_servers) do
  if not vim.tbl_contains(servers, name) then table.insert(servers, name) end
end

for _, name in ipairs(servers) do
  lsp.enable(name)
end
