local map = vim.keymap.set

-- remove useless defaults
map({ 'n', 'x' }, 's', '<Nop>')
map({ 'n', 'x' }, '<c-s>', '<Nop>')
map({ 'n', 'x' }, 'S', '<Nop>')
map({ 'n', 'x' }, 'r', '<Nop>')
map({ 'n', 'x' }, 'R', '<Nop>')

-- better up/down
map(
  { 'n', 'x' },
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { desc = 'Down', expr = true, silent = true }
)
map(
  { 'n', 'x' },
  '<Down>',
  "v:count == 0 ? 'gj' : 'j'",
  { desc = 'Down', expr = true, silent = true }
)
map(
  { 'n', 'x' },
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { desc = 'Up', expr = true, silent = true }
)
map(
  { 'n', 'x' },
  '<Up>',
  "v:count == 0 ? 'gk' : 'k'",
  { desc = 'Up', expr = true, silent = true }
)

-- move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map(
  'n',
  '<C-Left>',
  '<cmd>vertical resize -2<cr>',
  { desc = 'Decrease Window Width' }
)
map(
  'n',
  '<C-Right>',
  '<cmd>vertical resize +2<cr>',
  { desc = 'Increase Window Width' }
)

-- move lines
map(
  'n',
  '<C-S-j>',
  "<cmd>execute 'move .+' . v:count1<cr>==",
  { desc = 'Move Down' }
)
map(
  'n',
  '<C-S-k>',
  "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",
  { desc = 'Move Up' }
)
map('i', '<C-S-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<C-S-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map(
  'v',
  '<C-S-j>',
  ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
  { desc = 'Move Down' }
)
map(
  'v',
  '<C-S-k>',
  ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
  { desc = 'Move Up' }
)

-- buffers
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

-- clear search and stop snippet on escape
map({ 'i', 'n', 's' }, '<esc>', function()
  vim.cmd('noh')
  return '<esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })

-- clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  'n',
  '<leader>ur',
  '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
  { desc = 'Redraw / Clear hlsearch / Diff Update' }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map(
  'n',
  'n',
  "'Nn'[v:searchforward].'zv'",
  { expr = true, desc = 'Next Search Result' }
)
map(
  'x',
  'n',
  "'Nn'[v:searchforward]",
  { expr = true, desc = 'Next Search Result' }
)
map(
  'o',
  'n',
  "'Nn'[v:searchforward]",
  { expr = true, desc = 'Next Search Result' }
)
map(
  'n',
  'N',
  "'nN'[v:searchforward].'zv'",
  { expr = true, desc = 'Prev Search Result' }
)
map(
  'x',
  'N',
  "'nN'[v:searchforward]",
  { expr = true, desc = 'Prev Search Result' }
)
map(
  'o',
  'N',
  "'nN'[v:searchforward]",
  { expr = true, desc = 'Prev Search Result' }
)

-- add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- save file
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

--keywordprg
map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- commenting
map(
  'n',
  'gco',
  'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>',
  { desc = 'Add Comment Below' }
)
map(
  'n',
  'gcO',
  'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>',
  { desc = 'Add Comment Above' }
)

-- lazy
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- new file
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- location list
map('n', '<leader>xl', function()
  local success, err = pcall(
    vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose
      or vim.cmd.lopen
  )
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Location List' })

-- quickfix list
map('n', '<leader>xq', function()
  local success, err = pcall(
    vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose
      or vim.cmd.copen
  )
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Quickfix List' })

map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- highlights under cursor
map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
map('n', '<leader>uI', function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input('I')
end, { desc = 'Inspect Tree' })

-- terminal mappings
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- windows
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })

-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- native snippets. only needed on < 0.11, as 0.11 creates these by default
if vim.fn.has('nvim-0.11') == 0 then
  map('s', '<Tab>', function()
    return vim.snippet.active({ direction = 1 })
        and '<cmd>lua vim.snippet.jump(1)<cr>'
      or '<Tab>'
  end, { expr = true, desc = 'Jump Next' })
  map({ 'i', 's' }, '<S-Tab>', function()
    return vim.snippet.active({ direction = -1 })
        and '<cmd>lua vim.snippet.jump(-1)<cr>'
      or '<S-Tab>'
  end, { expr = true, desc = 'Jump Previous' })
end
