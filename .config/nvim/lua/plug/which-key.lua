return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'modern',
    triggers = {
      { '<auto>', mode = 'nixsotc' },
      -- { "s", mode = { "n", "v" } },
    },
    -- ---@type wk.Spec
    -- spec = {
    --   { "s", group = "surround" },
    --   { "g", group = "go" },
    --   { "<leader>s", group = "search" },
    --   { "<leader>t", group = "toggle" },
    --   { "<leader>g", group = "git", mode = { "n", "v" } },
    -- },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
