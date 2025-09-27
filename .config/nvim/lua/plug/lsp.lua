return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
      },
    },
  },
  { 'neovim/nvim-lspconfig' },
  { 'mason-org/mason.nvim', opts = {} },
  { 'j-hui/fidget.nvim', opts = {} },
  { 'b0o/SchemaStore.nvim', version = false },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      single_file_support = false,
      workspace_required = true,
      settings = {
        suggest = {
          names = false,
          autoImports = false,
        },
      },
    },
  },
}
