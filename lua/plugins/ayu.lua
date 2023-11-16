return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.wo.cursorline = true

    require("ayu").setup({
      mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
      overrides = {
        LineNr = { fg = "#8691A3" },
        -- Cursor = { fg = "#000000", bg = "#FFFFFF" },
        CursorLine = { bg = "#0A0E14" },
        CursorLineNr = { fg = "#FFCC66" },
        WhichKeyFloat = { bg = "#333C52" },
        Comment = { fg = "#8691A3" },
        TreesitterContext = { bg = "#333C52" },
      }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
    })

    local set_colorscheme = "silent! colorscheme ayu"
    vim.cmd(set_colorscheme)
  end
}
