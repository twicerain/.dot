require('opts')
require('globals')
require('keys')
require('boot')
require('acmd')

-- custom plugins
require('virtrnu').setup({
  freq = 5,
  padding = 4,
  align = 'left',
})

vim.keymap.set('n', '<leader>tv', '<CMD>Virtrnu toggle<CR>')
