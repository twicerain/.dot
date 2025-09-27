require('opts')
require('maps')
require('boot')
require('acmd')
require('lsp')

-- custom plugins
require('vrnu').setup({
  freq = 1,
  padding = 1,
  align = 'left',
})

vim.keymap.set('n', '<leader>tv', '<CMD>Virtrnu toggle<CR>')
