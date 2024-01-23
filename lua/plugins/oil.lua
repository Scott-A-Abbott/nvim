return {
  'stevearc/oil.nvim',
  opts = {
    keymaps = {
      ["q"] = "actions.close",
      ["g?"] = "actions.show_help",
      ["gp"] = "actions.preview",
      ["gr"] = "actions.refresh",
      -- ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      ["<CR>"] = "actions.select",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      -- ["`"] = "actions.cd",
      -- ["~"] = "actions.tcd",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = false,
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
