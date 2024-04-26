local function relative_path()
  return vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
end

local function current_directory()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons", "f-person/git-blame.nvim"},
  config = function()
    vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
    vim.g.gitblame_message_template = "<author> • <date>"
    vim.g.gitblame_date_format = "%x"

    local git_blame = require("gitblame")

    require "lualine".setup({
      options = { theme = "ayu" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { current_directory },
        lualine_c = { relative_path },
        lualine_x = {
          { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
        },
        lualine_y = {"branch"},
        lualine_z = {"location"}
      },
    })
  end
}
