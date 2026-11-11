return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    local snacks = require("snacks")

    snacks.setup({
      picker = {
        enabled = true,
        ui_select = true,
        win = {
          input = {
            keys = {
              -- Same as snacks' default <c-q> (swallowed by zellij): sends the
              -- selection to quickfix, or all results if nothing is selected.
              ["<a-a>"] = { "qflist", mode = { "n", "i" } }
            }
          }
        }
      }
    })

    local picker = snacks.picker

    require("which-key").add({
      { "<leader>f", group = "Fuzzy Find" },
      { "<leader>ff", function() picker.files() end, desc = "File" },
      { "<leader>fl", function() picker.grep() end, desc = "Live grep" },
      { "<leader>fr", function() picker.resume() end, desc = "Resume" },
      { "<leader>fb", function() picker.buffers() end, desc = "Buffers" },
      noremap = true
    })
  end
}
