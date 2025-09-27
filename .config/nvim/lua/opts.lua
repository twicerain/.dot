local g, o, opt = vim.g, vim.o, vim.opt

g.mapleader = ' '
g.maplocalleader = '\\'
g.ignored_filetypes = {
  'PlenaryTestPopup',
  'checkhealth',
  'dbout',
  'gitsigns-blame',
  'grug-far',
  'help',
  'lspinfo',
  'neotest-output',
  'neotest-output-panel',
  'neotest-summary',
  'notify',
  'qf',
  'spectre_panel',
  'startuptime',
  'tsplayground',
  'oil',
}
g.markdown_recommended_style = 0
g.markdown_fenced_languages = {
  'ts=typescript',
}

vim.schedule(function() o.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' end)

-- numbers
o.nu = true
o.rnu = true

-- ui
o.conceallevel = 2
o.winborder = 'rounded'
o.background = 'dark'
o.termguicolors = true
o.signcolumn = 'yes'
o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
o.laststatus = 3
o.showmode = false
o.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.cursorline = true
o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup
o.ruler = false -- Disable the default ruler
opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- behaviour
o.swapfile = false
o.confirm = true
o.updatetime = 200
o.timeoutlen = 300
o.jumpoptions = 'view'
o.mouse = 'a'

-- scrolling
o.scrolloff = 16
o.sidescrolloff = 16
o.virtualedit = 'block'
o.smoothscroll = true

-- undo
o.undofile = true
o.undolevels = 10000

-- split
o.splitkeep = 'screen'
o.splitright = true
o.splitbelow = true

-- spacing
o.ts = 2
o.sts = 2
o.sw = 2
o.shiftround = true
o.expandtab = true
o.smartindent = true
o.breakindent = true
o.wrap = false

-- search
o.inccommand = 'split'
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- fold
o.foldlevel = 99
o.foldmethod = 'indent'
o.foldtext = ''

-- format
o.formatoptions = 'jcroqlnt'
o.grepformat = '%f:%l:%c:%m'
o.grepprg = 'rg --vimgrep'
o.linebreak = true
o.wildmode = 'longest:full,full' -- Command-line completion mode
opt.sessionoptions = {
  'buffers',
  'curdir',
  'tabpages',
  'winsize',
  'help',
  'globals',
  'skiprtp',
  'folds',
}

-- spelling
o.spell = true
opt.spelllang = { 'en_au' }
o.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'
