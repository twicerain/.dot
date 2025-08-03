-- LSP Plugins
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      { 'mason-org/mason-lspconfig.nvim', opts = { automatic_enable = false } },
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      'saghen/blink.cmp',

      { 'b0o/SchemaStore.nvim', version = false },
    },
    config = function()
      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      ---@type vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = true },
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
        virtual_lines = {
          current_line = true,
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      ---@type {[string]: lspconfig.Config}
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                disable = { 'missing-fields', 'missing-parameter' },
              },
            },
          },
        },
        denols = {
          settings = {},
          root_dir = require('lspconfig').util.root_pattern({
            'deno.json',
            'deno.jsonc',
          }),
          single_file_support = false,
          workspace_required = true,
        },
        astro = {},
        jsonls = {
          settings = {
            json = {
              format = {
                enable = true,
              },
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        dockerls = {},
        docker_compose_language_service = {},
        rust_analyzer = {},
        gopls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'typescript-language-server',
      })

      require('mason-tool-installer').setup({
        ensure_installed = ensure_installed,
      })

      ---@type {[string]: lspconfig.Config}
      local remote_servers = {
        gdscript = {
          on_attach = function(client, _bufnr)
            local pipe_path = client.root_dir .. '/server.pipe'

            if vim.uv.fs_stat(pipe_path) then return end

            local success, server_addr = pcall(vim.fn.serverstart, pipe_path)
            if not success then vim.notify('Failed to start Godot server pipe: ' .. tostring(server_addr), 'warn') end
          end,
        },
      }

      for name, cfg in pairs(vim.tbl_deep_extend('force', servers, remote_servers)) do
        cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
        require('lspconfig')[name].setup(cfg)
      end
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      single_file_support = false,
      workspace_required = true,
      suggest = {
        names = false,
        autoImports = false,
      },
    },
  },
}
