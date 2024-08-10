return {
  "TimUntersberger/neogit",
  dependencies = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
  config = function()
    require("neogit").setup({
      integrations = { diffview = true },
      mappings = { status = { ["gk"] = "Untrack", ["K"] = false } }
    })

    require("which-key").add({
      { "<leader>g", group = "Git" },
      { "<leader>go", "<CMD>Neogit<CR>", desc = "Open" },
      { "<leader>gc", "<CMD>Neogit commit<CR>", desc = "Commit" },
      { "<leader>gp", "<CMD>Neogit pull<CR>", desc = "Pull" },
      { "<leader>gl", "<CMD>Neogit log<CR>", desc = "Log" },
      noremap = true
    })
  end
}
