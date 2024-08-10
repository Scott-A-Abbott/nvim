return {
  "folke/flash.nvim",
  config = function()
    local flash = require("flash")

    flash.setup({
      jump = { nohsearch = true },
      modes = { search = { enabled = true } }
    })

    local flash_line_jump = {
      "<leader>l",
      function()
        flash.jump({
          search = { mode = "search", max_length = 0 },
          label = { after = { 0, 0 } },
          pattern = "^"
        })
      end,
      desc = "Flash line"
    }

    local flash_forwards = {
      "<leader>/",
      function()
        flash.jump({
          search = { forward = true, wrap = false, multi_window = false },
        })
      end,
      desc = "Flash forwards"
    }

    local flash_backwards = {
      "<leader>?",
      function()
        flash.jump({
          search = { forward = false, wrap = false, multi_window = false },
        })
      end,
      desc = "Flash backwards"
    }

    require("which-key").add({
      flash_line_jump,
      flash_forwards,
      flash_backwards,
      mode = { "n", "v" },
      noremap = true
    })
  end
}
