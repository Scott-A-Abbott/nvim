return {
  "folke/which-key.nvim",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    preset = "modern",
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    win = {
      border = "double", -- none, single, double, shadow
      -- position = "bottom", -- bottom, top
      -- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2 }, -- extra window padding [top, right, bottom, left]
      wo = {
        winblend = 0
      }
    },
    -- This is deprecated...
    -- hidden = { "<silent>", "<CR>", "call", "lua", "^:", "^ "},
  },
  keys = {
    { "<leader>?", "<CMD>WhichKey<CR>", desc = "Key Mappings", mode = { "n", "v" } }
  }
}
