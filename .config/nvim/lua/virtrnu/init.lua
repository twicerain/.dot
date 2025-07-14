---@class VirtRNU
local M = {}
local ns = vim.api.nvim_create_namespace("virtrnu")
local augroup = vim.api.nvim_create_augroup("virtrnu_group", { clear = true })

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
  align = "left",
  padding = 16,
  hlgroup = "LineNr",
  hide_empty = true,
}

local ignored_buftypes = {
  "nofile",
  "prompt",
  "terminal",
  "quickfix",
}
local function is_disabled_buf(bufnr)
  local bt = vim.bo[bufnr].buftype
  return vim.tbl_contains(ignored_buftypes, bt)
end

---@type Config
M.config = config

function M.update(bufnr)
  if not config.enabled or not vim.api.nvim_buf_is_loaded(bufnr) or is_disabled_buf(bufnr) then
    return
  end

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    local rel = math.abs(i - cursor_line)
    local is_current = (i == cursor_line)
    local is_nonempty = not config.hide_empty or line:match("%S")
    if is_current then
      local col = vim.api.nvim_win_get_cursor(0)[2] + 1
      local info = ("%d:%d"):format(cursor_line, col)
      vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
        virt_text = {
          {
            string.rep(" ", config.align == "left" and config.padding or 0)
              .. info
              .. string.rep(" ", config.align == "right" and config.padding or 0),
            config.hlgroup,
          },
        },
        virt_text_pos = config.align == "left" and "eol" or "eol_right_align",
        hl_mode = "combine",
      })
    elseif is_nonempty and rel % config.freq == 0 then
      vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
        virt_text = {
          {
            string.rep(" ", config.align == "left" and config.padding or 0)
              .. tostring(rel)
              .. string.rep(" ", config.align == "right" and config.padding or 0),
            config.hlgroup,
          },
        },
        virt_text_pos = config.align == "left" and "eol" or "eol_right_align",
        hl_mode = "combine",
      })
    end
  end
end

function M.attach(bufnr)
  vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter", "BufWinEnter" }, {
    group = augroup,
    buffer = bufnr,
    callback = function()
      M.update(bufnr)
    end,
  })
end

function M.enable()
  config.enabled = true
  vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    callback = function(args)
      if config.enabled then
        M.attach(args.buf)
      end
    end,
  })

  local bufnr = vim.api.nvim_get_current_buf()
  M.attach(bufnr)
  M.update(bufnr)
end

function M.disable()
  config.enabled = false
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
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
  config = vim.tbl_deep_extend("force", config, opts or {})
  if config.enabled then
    M.enable()
  end

  vim.api.nvim_create_user_command("Virtrnu", function(params)
    local sub = params.fargs[1]
    if sub == "toggle" then
      M.toggle()
    elseif sub == "enable" then
      M.enable()
    elseif sub == "disable" then
      M.disable()
    else
      vim.notify("Unknown subcommand: " .. (sub or ""), vim.log.levels.ERROR)
    end
  end, {
    nargs = "+",
    complete = function()
      return { "toggle", "enable", "disable" }
    end,
  })
end

return M
