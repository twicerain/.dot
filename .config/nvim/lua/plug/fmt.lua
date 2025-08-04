local prettierlangs = {
  'astro',
  'css',
  'graphql',
  'handlebars',
  'html',
  'javascript',
  'javascriptreact',
  'json',
  'jsonc',
  'less',
  'markdown',
  'markdown.mdx',
  'scss',
  'typescript',
  'typescriptreact',
  'vue',
  'yaml',
}

local get_prettier_formatters = function(langs)
  local ft_formatters = {}
  for _, ft in ipairs(langs) do
    ft_formatters[ft] = { 'prettierd', 'prettier', stop_after_first = true }
  end

  return ft_formatters
end

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_on_save = { timeout_ms = 1000, lsp_format = 'fallback' },
    formatters_by_ft = vim.tbl_extend('force', {
      lua = { 'stylua' },
    }, get_prettier_formatters(prettierlangs)),
  },
}
