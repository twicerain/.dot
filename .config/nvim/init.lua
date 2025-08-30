require('opts')
require('globals')
require('keys')
require('boot')
require('acmd')

-- custom plugins
require('vrnu.init').setup({
  freq = 1,
  padding = 0,
  align = 'left',
})
