vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.o.background = 'dark'

vim.schedule(function()
  vim.o.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- Sync with system clipboard
end)

vim.o.nu = true
vim.o.rnu = true

vim.o.ts = 2
vim.o.sts = 2
vim.o.sw = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.wrap = false

vim.o.termguicolors = true

vim.o.mouse = 'a'
vim.o.showmode = false

vim.o.undofile = true

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

vim.o.signcolumn = 'yes'

vim.o.updatetime = 200
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.cursorline = true
vim.o.scrolloff = 16

vim.o.confirm = true

vim.o.autowrite = true -- Enable auto write
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.expandtab = true -- Use spaces instead of tabs
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
vim.o.foldlevel = 99
vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
vim.o.formatoptions = 'jcroqlnt' -- tcqj
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg = 'rg --vimgrep'
vim.o.ignorecase = true -- Ignore case
vim.o.inccommand = 'nosplit' -- preview incremental substitute
vim.o.jumpoptions = 'view'
vim.o.laststatus = 3 -- global statusline
vim.o.linebreak = true -- Wrap lines at convenient points
vim.o.list = true -- Show some invisible characters (tabs...
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.number = true -- Print line number
vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup
vim.o.ruler = false -- Disable the default ruler
vim.opt.sessionoptions = {
  'buffers',
  'curdir',
  'tabpages',
  'winsize',
  'help',
  'globals',
  'skiprtp',
  'folds',
}
vim.o.shiftround = true -- Round indent
vim.o.shiftwidth = 2 -- Size of an indent
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.o.sidescrolloff = 8 -- Columns of context
vim.o.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.spell = true
vim.opt.spelllang = { 'en_au' }
vim.o.splitkeep = 'screen'
vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
vim.o.undolevels = 10000
vim.o.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.o.wildmode = 'longest:full,full' -- Command-line completion mode
vim.o.winminwidth = 5 -- Minimum window width
vim.o.winborder = 'rounded'

vim.o.smoothscroll = true
vim.o.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
vim.o.foldmethod = 'expr'
vim.o.foldtext = ''
vim.o.swapfile = false

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.filetype.add({
  pattern = {
    ['.*compose.*%.ya?ml'] = 'yaml.docker-compose',
  },
})

vim.lsp.log.set_level(vim.log.levels.OFF)
