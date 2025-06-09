return {
  'folke/noice.nvim',
  ---@class noice.Config
  opts = {
    presets = {
      bttom_search = false,
      command_palette = true,
      lsp_doc_border = true,
    },
    views = {
      confirm = {
        enter = true,
      },
      cmdline_popup = {
        position = {
          row = '50%',
          col = '50%',
        },
      },
    },
    lsp = {
      hover = {
        silent = true,
      },
    },
  },
}
