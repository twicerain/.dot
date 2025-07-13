local M = {}
M.tokyonight = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({})
    vim.cmd.colorscheme("tokyonight-night")
  end,
}

M.zenbones = {
  "zenbones-theme/zenbones.nvim",
  dependencies = "rktjmp/lush.nvim",
  lazy = false,
  priority = 1000,
  -- you can set set configuration options here
  config = function()
    vim.cmd.colorscheme("zenbones")
  end,
}

M.everforest = {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({})
    vim.cmd.colorscheme("everforest")
  end,
}

return M.zenbones
