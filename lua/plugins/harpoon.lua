return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("harpoon").setup()

    local harpoon_ui = require("harpoon.ui")
    local harpoon_mark = require("harpoon.mark")

    require("which-key").add({
      { "<leader>h", harpoon_ui.toggle_quick_menu, desc = "Harpoon toggle" },
      { "<leader>m", harpoon_mark.add_file, desc = "Harpoon mark" },
      -- ## Verify what these mappings are on Windows/Linux
      { "<leader>>", harpoon_ui.nav_next, desc = "Harpoon next" },
      { "<leader><", harpoon_ui.nav_prev, desc = "Harpoon prev" },
      noremap = true
    })
  end
}
