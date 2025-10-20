return {
  'neovim/nvim-lspconfig',
  lazy = false,
  config = function ()
    vim.lsp.config('rust_analyzer', {
      -- Server-specific settings. See `:help lsp-quickstart`
      settings = {
        ['rust-analyzer'] = {},
      },
    })

    vim.lsp.enable('marksman')

    vim.lsp.enable('typos-lsp')
  end,
}
