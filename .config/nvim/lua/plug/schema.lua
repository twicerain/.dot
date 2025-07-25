return {
  'b0o/SchemaStore.nvim',
  version = false,
  config = function()
    require('lspconfig').jsonls.setup({
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })
  end,
}
