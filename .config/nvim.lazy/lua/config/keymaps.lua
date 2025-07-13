-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local smart_splits = require('smart-splits')

-- vim.keymap.set('n', '<C-Left>', smart_splits.resize_left)
-- vim.keymap.set('n', '<C-Down>', smart_splits.resize_down)
-- vim.keymap.set('n', '<C-Up>', smart_splits.resize_up)
-- vim.keymap.set('n', '<C-Right>', smart_splits.resize_right)
-- -- moving between splits
-- vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
-- vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
-- vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
-- vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right)
-- vim.keymap.set('n', '<C-\\>', smart_splits.move_cursor_previous)
-- -- swapping buffers between windows
-- vim.keymap.set('n', '<leader><leader>h', smart_splits.swap_buf_left)
-- vim.keymap.set('n', '<leader><leader>j', smart_splits.swap_buf_down)
-- vim.keymap.set('n', '<leader><leader>k', smart_splits.swap_buf_up)
-- vim.keymap.set('n', '<leader><leader>l', smart_splits.swap_buf_right)

-- Treewalker
-- movement
vim.keymap.set({ 'n', 'v' }, '<M-S-k>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<M-S-j>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<M-S-h>', '<cmd>Treewalker Left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<M-S-l>', '<cmd>Treewalker Right<cr>', { silent = true })

-- swapping
-- vim.keymap.set('n', '<M-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
-- vim.keymap.set('n', '<M-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
-- vim.keymap.set('n', '<M-S-h>', '<cmd>Treewalker SwapLeft<CR>', { silent = true })
-- vim.keymap.set('n', '<M-S-l>', '<cmd>Treewalker SwapRight<CR>', { silent = true })
