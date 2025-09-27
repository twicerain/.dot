local map = vim.keymap.set

-- remove useless defaults
map({ 'n', 'x' }, 's', '<Nop>')
map({ 'n', 'x' }, '<c-s>', '<Nop>')
map({ 'n', 'x' }, 'S', '<Nop>')
map({ 'n', 'x' }, 'r', '<Nop>')
map({ 'n', 'x' }, 'R', '<Nop>')

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'up', expr = true, silent = true })

-- move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'go to left window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'go to lower window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'go to upper window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'go to right window', remap = true })

-- resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'increase window width' })

-- move lines
map('n', '<C-S-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'move down' })
map('n', '<C-S-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'move up' })
map('i', '<C-S-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'move down' })
map('i', '<C-S-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'move up' })
map('v', '<C-S-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<C-S-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- buffers
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'prev buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'next buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'prev buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'next buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'switch to other buffer' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'switch to other buffer' })
map('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'delete buffer and window' })

-- clear search and stop snippet on escape
map({ 'i', 'n', 's' }, '<esc>', function()
  vim.cmd('noh')
  return '<esc>'
end, { expr = true, desc = 'escape and clear hlsearch' })

-- clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  'n',
  '<leader>ur',
  '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
  { desc = 'redraw / clear hlsearch / diff update' }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'next search result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'prev search result' })

-- add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- save file
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'save file' })

--keywordprg
map('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'keywordprg' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- commenting
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'add comment below' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'add comment above' })

-- lazy
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'lazy' })

-- new file
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'new file' })

-- location list
map('n', '<leader>xl', function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'location list' })

-- quickfix list
map('n', '<leader>xq', function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = 'quickfix list' })

map('n', '[q', vim.cmd.cprev, { desc = 'previous quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'next quickfix' })

-- diagnostic
local diagnostic_goto = function(count, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() vim.diagnostic.jump({ count = count, severity = severity, float = true }) end
end
local severity = vim.diagnostic.severity
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'line diagnostics' })
map('n', ']e', diagnostic_goto(1, severity.ERROR), { desc = 'next error' })
map('n', '[e', diagnostic_goto(-1, severity.ERROR), { desc = 'prev error' })
map('n', ']w', diagnostic_goto(1, severity.WARN), { desc = 'next warning' })
map('n', '[w', diagnostic_goto(-1, severity.WARN), { desc = 'prev warning' })

-- highlights under cursor
map('n', '<leader>ui', vim.show_pos, { desc = 'inspect pos' })
map('n', '<leader>uI', function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input('I')
end, { desc = 'inspect tree' })

-- terminal mappings
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'hide terminal' })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- windows
map('n', '<leader>-', '<C-W>s', { desc = 'split window below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'split window right', remap = true })
map('n', '<leader>wd', '<C-W>c', { desc = 'delete window', remap = true })

-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'last tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'close other tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'first tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'new tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'next tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'close tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'previous tab' })
