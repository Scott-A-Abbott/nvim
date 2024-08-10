return {
  "mg979/vim-visual-multi",
  config = function()
    local keymap_options = { noremap = true }
    vim.api.nvim_set_keymap("n", "<C-d>", "<Plug>(VM-Add-Cursor-Down)", keymap_options)
    vim.api.nvim_set_keymap("n", "<C-u>", "<Plug>(VM-Add-Cursor-Up)", keymap_options)
    vim.api.nvim_set_keymap("n", "<C-f>", "<Plug>(VM-Add-Cursor-At-Word)", keymap_options)
    vim.api.nvim_set_keymap("v", "<C-f>", "<Plug>(VM-Find-Subword-Under)", keymap_options)
  end
}
