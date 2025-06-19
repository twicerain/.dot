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
      width = 60,
      preset = {
        ---@type snacks.dashboard.Section
        startup = { section },
        header = 'amk',
        keys = {
          {
            icon = ' ',
            key = 'n',
            desc = 'new',
            action = ':ene | startinsert',
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'recent',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = ' ',
            key = 'c',
            desc = 'config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          -- { icon = " ", key = "s", desc = "restore session", section = "session" },
          {
            icon = '󰒲 ',
            key = 'L',
            desc = 'lazy',
            action = ':Lazy',
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = ' ', key = 'q', desc = 'quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        function()
          if Snacks.git.get_root() == nil then return {} end

          local icon = ' '
          local cmd =
            'printf (set_color -o cyan)"\r $(set_color magenta)%s\n$(set_color normal)" $(git branch);  git diff --stat -M -R -C --abbrev'
          local git_output = vim.fn.system(cmd)
          local count = select(2, git_output:gsub('\n', '\n'))
          return {
            height = math.max(math.min(count, 5), 1),
            padding = 1,
            section = 'terminal',
            enabled = function() return Snacks.git.get_root() ~= nil end,
            cmd = cmd,
            tty = 5 * 60,
          }
        end,
        { icon = ' ', section = 'recent_files', padding = 1 },
        { section = 'keys', padding = 1 },
        { section = 'startup' },
      },
    },
  },
}
