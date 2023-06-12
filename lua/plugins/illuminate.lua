return {
  'RRethy/vim-illuminate',
  config = function()
    vim.cmd("hi IlluminatedWordText gui=NONE guibg=#323a4c")
    vim.cmd("hi IlluminatedWordRead gui=NONE guibg=#323a4c")
    vim.cmd("hi IlluminatedWordWrite gui=NONE guibg=#323a4c")
  end
}
