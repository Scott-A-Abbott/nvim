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

    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          -- Code action groups
          vim.keymap.set("n", "<C-.>", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
    })

    require('lsp-setup').setup({
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
