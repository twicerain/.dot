return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = { -- Snippet Engine
      'rafamadriz/friendly-snippets',
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      cmdline = {
        enabled = true,
        completion = {
          ghost_text = {
            enabled = true,
          },
          menu = {
            auto_show = true,
          },
          list = {
            selection = {
              auto_insert = false,
              preselect = true,
            },
          },
        },
      },

      completion = {
        ghost_text = {
          enabled = true,
          show_with_selection = true,
          show_without_selection = true,
          show_with_menu = true,
          show_without_menu = true,
        },

        documentation = {
          window = {
            border = 'rounded',
          },
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        menu = {
          border = 'rounded',
          draw = {
            columns = {
              { 'kind_icon', 'label', 'label_description', gap = 1 },
              { 'kind' },
            },
          },
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },

      snippets = { preset = 'default' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      signature = { enabled = true },
    },
  },
}
