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
    vim.lsp.enable('rust_analyzer')

    vim.lsp.enable('marksman')

    vim.lsp.config('typos-lsp', {
      cmd = { 'typos-lsp' },
      init_options = {
        diagnosticSeverity = 'Error'
      },
    })
    vim.lsp.enable('typos-lsp')
  end,
}
