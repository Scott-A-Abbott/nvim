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
      ["`"] = function()
        require("oil.actions").cd.callback()

        local current_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        vim.cmd(string.format("silent !zellij action rename-tab %s", current_dir))
      end
      -- ["~"] = "actions.tcd",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = false,
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
