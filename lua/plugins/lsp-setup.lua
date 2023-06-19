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
      servers = {
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
        rust_analyzer = {}
      }
    })
  end,
}
