-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_prettier_needs_config = false
vim.filetype.add({
  pattern = {
    ['.*/.zsh/.*'] = 'zsh',
  },
})

vim.g.root_spec = { { '.git', 'lua' }, 'cwd', 'lsp' }
-- vim.opt.swapfile = false
vim.api.nvim_set_option_value('swapfile', false, { scope = 'global' })

vim.diagnostic.enable(true)
vim.diagnostic.config({ virtual_lines = { current_line = true } })
