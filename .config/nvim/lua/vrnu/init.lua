---@class VRNU
local M = {}
local ns = vim.api.nvim_create_namespace('vrnu')
local augroup = vim.api.nvim_create_augroup('vrnu_group', { clear = true })

---@class Config
---@field enabled boolean
---@field freq integer
---@field align 'left' | 'right'
---@field padding integer
---@field hlgroup string
---@field hide_empty boolean
local config = {
  enabled = true,
  freq = 1,
  align = 'left',
  padding = 16,
  hlgroup = 'LineNr',
  hide_empty = true,
  debounce = 10,
  max_debounce = vim.o.updatetime,
}

local cache = {
  prev_line = 0,
  prev_col = 0,
  prev_count = 0,
  timer = nil,
  curr_debounce = 0,
  pending_update = false,
}

local ignored_buftypes = {
  'nofile',
  'prompt',
  'terminal',
  'quickfix',
}

local function is_ignored(bufnr)
  local bt = vim.bo[bufnr].buftype
  local ft = vim.bo[bufnr].filetype
  return vim.tbl_contains(ignored_buftypes, bt)
    or vim.tbl_contains(vim.g.ignored_filetypes, ft)
end

---@type Config
M.config = config

function M.update(bufnr, force)
  if
    not config.enabled
    or not vim.api.nvim_buf_is_valid(bufnr)
    or not vim.api.nvim_buf_is_loaded(bufnr)
    or is_ignored(bufnr)
  then
    return
  end

  local winid = vim.fn.bufwinid(bufnr)
  if winid == -1 then return end

  local pos = vim.api.nvim_win_get_cursor(winid)
  local curr_line = pos[1]
  local curr_col = pos[2]
  local curr_count = vim.api.nvim_buf_line_count(bufnr)

  if
    not force
    and cache.prev_line == curr_line
    and cache.prev_col == curr_col
    and cache.prev_count == curr_count
  then
    return
  end

  cache.prev_line = curr_line
  cache.prev_col = curr_col
  cache.prev_count = curr_count

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local win_info = vim.fn.getwininfo(winid)[1]
  if not win_info then return end

  local start_line = math.max(1, win_info.topline - 50)
  local end_line = math.max(1, win_info.botline + 50)
  local lines =
    vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

  for i, line in ipairs(lines) do
    local abs = start_line + i - 1
    local rel = math.abs(abs - curr_line)
    local is_current = (abs == curr_line)
    local is_nonempty = not config.hide_empty or line:match('%S')

    if is_current then
      local col = curr_col + 1
      local info = ('%d:%d'):format(curr_line, col)
      vim.api.nvim_buf_set_extmark(bufnr, ns, abs - 1, 0, {
        virt_text = {
          {
            string.rep(' ', config.align == 'left' and config.padding or 0)
              .. info
              .. string.rep(
                ' ',
                config.align == 'right' and config.padding or 0
              ),
            config.hlgroup,
          },
        },
        virt_text_pos = config.align == 'left' and 'eol' or 'eol_right_align',
        hl_mode = 'combine',
      })
    elseif is_nonempty and rel % config.freq == 0 then
      vim.api.nvim_buf_set_extmark(bufnr, ns, abs - 1, 0, {
        virt_text = {
          {
            string.rep(' ', config.align == 'left' and config.padding or 0)
              .. tostring(rel)
              .. string.rep(
                ' ',
                config.align == 'right' and config.padding or 0
              ),
            config.hlgroup,
          },
        },
        virt_text_pos = config.align == 'left' and 'eol' or 'eol_right_align',
        hl_mode = 'combine',
      })
    end
  end
end

local function debounced_update(bufnr)
  if not cache.timer then
    cache.curr_debounce = config.debounce
    cache.pending_update = false
    M.update(bufnr)
  else
    if not cache.pending_update then
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      cache.pending_update = true
    end

    cache.timer:stop()
    cache.curr_debounce =
      math.min(cache.curr_debounce * 1.5, config.max_debounce)
  end

  cache.timer = vim.defer_fn(function()
    cache.timer = nil
    cache.curr_debounce = config.debounce

    if cache.pending_update then
      cache.pending_update = false
      M.update(bufnr, true)
    end
  end, cache.curr_debounce)
end

function M.attach(bufnr)
  vim.api.nvim_clear_autocmds({
    group = augroup,
    buffer = bufnr,
  })

  vim.api.nvim_create_autocmd(
    { 'CursorMoved', 'CursorMovedI', 'WinScrolled' },
    {
      group = augroup,
      buffer = bufnr,
      callback = function() debounced_update(bufnr) end,
    }
  )

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    group = augroup,
    buffer = bufnr,
    callback = function() M.update(bufnr) end,
  })

  vim.api.nvim_create_autocmd('BufUnload', {
    group = augroup,
    buffer = bufnr,
    callback = function()
      if cache.timer then
        cache.timer:stop()
        cache.timer = nil
      end
    end,
  })
end

function M.enable()
  config.enabled = true
  vim.api.nvim_clear_autocmds({ group = augroup })

  vim.api.nvim_create_autocmd('BufEnter', {
    group = augroup,
    callback = function(args)
      if config.enabled and not is_ignored(args.buf) then M.attach(args.buf) end
    end,
  })

  local bufnr = vim.api.nvim_get_current_buf()
  if not is_ignored(bufnr) then
    M.attach(bufnr)
    M.update(bufnr)
  end
end

function M.disable()
  config.enabled = false

  if cache.timer then
    cache.timer:stop()
    cache.timer = nil
  end

  cache.curr_debounce = config.debounce
  cache.pending_update = false

  vim.api.nvim_clear_autocmds({ group = augroup })

  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
end

function M.toggle()
  if config.enabled then
    M.disable()
  else
    M.enable()
  end
end

---@param opts Config?
function M.setup(opts)
  config = vim.tbl_deep_extend('force', config, opts or {})
  if config.enabled then M.enable() end

  vim.api.nvim_create_user_command('Vrnu', function(params)
    local sub = params.fargs[1]
    if not sub or sub == 'toggle' then
      M.toggle()
    elseif sub == 'enable' then
      M.enable()
    elseif sub == 'disable' then
      M.disable()
    elseif sub == 'status' then
      local status = config.enabled and 'enabled' or 'disabled'
      local debounce_status = cache.timer
          and (' (debouncing: %dms)'):format(cache.curr_debounce)
        or ''
      vim.notify('Vrnu: ' .. status .. debounce_status)
    else
      vim.notify('Unknown subcommand: ' .. sub, vim.log.levels.ERROR)
    end
  end, {
    nargs = '?',
    complete = function() return { 'toggle', 'enable', 'disable', 'status' } end,
  })
end

return M
