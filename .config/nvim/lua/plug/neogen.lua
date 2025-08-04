return {
  'danymat/neogen',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
    },
  },
  keys = {
    {
      '<leader>cn',
      function() require('neogen').generate() end,
      desc = 'Generate Annotations (Neogen)',
    },
  },
  opts = {
    snippet_engine = 'luasnip',
  },
}
