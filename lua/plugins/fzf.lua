return {
  'ibhagwan/fzf-lua',
  config = function()
    fzf = require("fzf-lua")

    fzf.setup({
      keymap = {
        fzf = { ["alt-a"] = "select-all+accept" }
      }
    })

    fzf.register_ui_select()

    require("which-key").add({
      { "<leader>f", group = "Fuzzy Find" },
      { "<leader>ff", "<CMD>FzfLua files<CR>", desc = "File" },
      { "<leader>fl", "<CMD>FzfLua live_grep<CR>", desc = "Live grep" },
      { "<leader>fr", "<CMD>FzfLua resume<CR>", desc = "Resume grep" },
      { "<leader>fb", "<CMD>FzfLua buffers<CR>", desc = "Buffers" },
      noremap = true
    })
  end
}
