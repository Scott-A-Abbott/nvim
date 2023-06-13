return {
  'junnplus/lsp-setup.nvim',

  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'simrat39/rust-tools.nvim',
  },

  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
    require("rust-tools").setup()

    require('lsp-setup').setup({
      default_mappings = false,
      mappings = {
        gD = 'lua vim.lsp.buf.declaration()',
        gd = 'lua vim.lsp.buf.definition()',
        gt = 'lua vim.lsp.buf.type_definition()',
        gi = 'lua vim.lsp.buf.implementation()',
        gr = 'lua vim.lsp.buf.references()',
        -- ['<C-k>'] = 'lua vim.lsp.buf.signature_help()',
        ['<space>rn'] = 'lua vim.lsp.buf.rename()',
        ['<space>ca'] = 'lua vim.lsp.buf.code_action()',
        ['<space>ch'] = 'lua vim.lsp.buf.hover()',
        ['<space>f'] = 'lua vim.lsp.buf.formatting()',
        ['<space>e'] = 'lua vim.diagnostic.open_float()',
        ['[d'] = 'lua vim.diagnostic.goto_prev()',
        [']d'] = 'lua vim.diagnostic.goto_next()',
      },
      servers = {
        bashls = {},
        cssls = {},
        jsonls = {},
        tsserver = {},
        lua_ls = {
          settings = {
            Lua = {
              format = {
                enable = false,
              }
            },
          },
        },
        marksman = {},
        standardrb = {},
        taplo = {},
        yamlls = {},
        rust_analyzer = {}
      }
    })
  end,
}
