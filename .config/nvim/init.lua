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
