return {
  "TimUntersberger/neogit",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neogit").setup({
      integrations = {
        fzf_lua = true,
      },
      filewatcher = {
        interval = 500
      },
      mappings = { status = { ["gk"] = "Untrack", ["K"] = false } },
      commit_editor = {
        kind = "vsplit",
        show_stage_diff = false,
      },
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
