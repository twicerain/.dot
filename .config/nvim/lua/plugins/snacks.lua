return {
  'folke/snacks.nvim',
  opts = {
    ---@type snacks.picker.Config
    picker = {
      sources = {
        explorer = {
          layout = {
            preset = 'sidebar',
            layout = {
              position = 'right',
            },
          },
        },
        buffers = {
          preview = 'main',
          focus = 'list',
          layout = {
            preset = 'select',
          },
        },
      },
    },
    indent = {
      enabled = true,
      chunk = {
        enabled = true,
        char = {
          corner_top = '╭',
          corner_bottom = '╰',
          horizontal = '─',
          vertical = '│',
          arrow = '►',
        },
      },
    },
    dashboard = {
      preset = {
        header = [[
╭─ ╭─╮ · ╭─╮ ╭─ ╭─╮ · ╭─╮
│  ├─┤ │ │ │ │  ├─┤ │ │ │
        ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      -- stylua: ignore
      ---@type snacks.dashboard.Section[]
      sections = {
        { section = "header" },
        { icon = " ", title = "Recent", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { sections = "startup" },
      },
    },
  },
}
