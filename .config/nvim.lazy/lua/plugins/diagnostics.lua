return {
  'rachartier/tiny-inline-diagnostic.nvim',
  enabled = false, -- nvim 11 has beautiful inline virtual comments
  event = 'VeryLazy', -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
  end,
}
