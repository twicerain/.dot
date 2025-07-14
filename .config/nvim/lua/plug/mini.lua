return {
  {
    'echasnovski/mini.pairs',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_ts = { 'string' },
      skip_unbalanced = true,
      markdown = true,
    },
  },
  {
    'echasnovski/mini.ai',
  },
  {
    'echasnovski/mini.operators',
  },
  {
    'echasnovski/mini.surround',
    opts = {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
      },
    },
    keys = function(plug, _)
      local m = plug.opts.mappings
      return {
        { m.add, desc = 'Add Surrounding', mode = { 'n', 'v' } },
        { m.delete, desc = 'Delete Surrounding' },
        { m.find, desc = 'Find Right Surrounding' },
        { m.find_left, desc = 'Find Left Surrounding' },
        { m.highlight, desc = 'Highlight Surrounding' },
        { m.replace, desc = 'Replace Surrounding' },
        { m.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
      }
    end,
  },
}
