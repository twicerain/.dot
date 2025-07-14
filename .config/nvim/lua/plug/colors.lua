return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("tokyonight").setup({})
    --   vim.cmd.colorscheme("tokyonight-night")
    -- end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("zenbones")
    end,
  },
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("everforest").setup({})
    --   vim.cmd.colorscheme("everforest")
    -- end,
  },
}
