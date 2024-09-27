return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local wk = require("which-key")

    wk.add({
      { "<C-d>", function() mc.addCursor("j") end, desc = "Add cursor up" },
      { "<C-u>", function() mc.addCursor("k") end, desc = "Add cursor down" },
      { "<C-f>", function() mc.addCursor("*") end, desc = "Add a cursor and jump to next word" },
      { "<C-a>", function() mc.skipCursor("*") end, desc = "Jump to next word under cursor" },
      noremap = true
    })

    wk.add({
      {
        "<esc>",
        function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          elseif mc.hasCursors() then
            mc.clearCursors()
          else
            -- Default <esc> handler.
          end
        end
      }
    })
  end
}
