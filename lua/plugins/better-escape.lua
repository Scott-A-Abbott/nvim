return {
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup({ timeout = 250, clear_empty_lines = true })
  end
}
