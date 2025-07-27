-- autocmds
local function augroup(name)
  return vim.api.nvim_create_augroup('rain' .. name, { clear = true })
end

-- Toggle relative line numbers off in insert mode
local toggle_ln_aug = augroup('toggle_ln')
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  group = toggle_ln_aug,
  callback = function()
    if vim.wo.nu then
      vim.wo.rnu = true
    end
  end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  group = toggle_ln_aug,
  callback = function()
    if vim.wo.nu then
      vim.wo.rnu = false
    end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if
      vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc
    then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = vim.g.ignored_filetypes,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        if vim.bo[event.buf].filetype == 'oil' then
          vim.cmd('b#')
        else
          vim.cmd('close')
        end
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('man_unlisted'),
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup('json_conceal'),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+:[\\/][\\/]') then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
  group = augroup('diagnostic_virt_text_hide'),
  callback = function(event)
    local lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
    lnum = lnum - 1 -- need 0-based index

    local hidden_lnum = vim.b[event.buf].diagnostic_hidden_lnum
    if hidden_lnum and hidden_lnum ~= lnum then
      vim.b[event.buf].diagnostic_hidden_lnum = nil
      -- display all the decorations if the current line changed
      vim.diagnostic.show(nil, event.buf)
    end

    for _, namespace in pairs(vim.diagnostic.get_namespaces()) do
      local ns_id = namespace.user_data.virt_text_ns
      if ns_id then
        local extmarks = vim.api.nvim_buf_get_extmarks(
          event.buf,
          ns_id,
          { lnum, 0 },
          { lnum, -1 },
          {}
        )
        for _, extmark in pairs(extmarks) do
          local id = extmark[1]
          vim.api.nvim_buf_del_extmark(event.buf, ns_id, id)
        end

        if extmarks and not vim.b[event.buf].diagnostic_hidden_lnum then
          vim.b[event.buf].diagnostic_hidden_lnum = lnum
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup('lspattach'),
  callback = function(event)
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client:supports_method(
        vim.lsp.protocol.Methods.textDocument_documentHighlight,
        event.buf
      )
    then
      local hl_group = augroup('lsphighlight')
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = hl_group,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = hl_group,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = augroup('lspdetach'),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = hl_group,
            buffer = event2.buf,
          })
        end,
      })
    end

    -- toggle inline hints
    if
      client
      and client:supports_method(
        vim.lsp.protocol.Methods.textDocument_inlayHint,
        event.buf
      )
    then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
        )
      end, {
        buffer = event.buf,
        desc = 'LSP: toggle Inlay hints',
      })
    end
  end,
})
