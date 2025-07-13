local lsp = require('lspconfig')

return {
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      denols = {
        filetypes = {
          'typescript',
          'typescriptreact',
        },
        root_dir = function(...)
          return lsp.util.root_pattern('deno.jsonc', 'deno.json')(...)
        end,
      },
      vtsls = {
        root_dir = lsp.util.root_pattern('package.json'),
      },
    },
  },
}
