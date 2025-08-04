require('opts')
require('globals')
require('keys')
require('boot')
require('acmd')

-- custom plugins
require('virtrnu').setup({
  freq = 1,
  padding = 1,
  align = 'left',
})

vim.keymap.set('n', '<leader>tv', '<CMD>Virtrnu toggle<CR>')
