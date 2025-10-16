return {
  "nvim-treesitter/nvim-treesitter-context",
  main = "treesitter-context",
  config = function()
    require("treesitter-context").setup({ enable = false })

    require("which-key").add({
      { "<leader>T", group = "Treesitter" },
      { "<leader>Tc", "<CMD>TSContext toggle<CR>" , desc = "Context" },
      noremap = true
    })
  end
}
