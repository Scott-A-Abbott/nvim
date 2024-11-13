return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      keymaps = {
        ["q"] = "actions.close",
        ["Y"] = function()
          local oil = require("oil")
          local entry = oil.get_cursor_entry()
          local current_dir = oil.get_current_dir()

          if not entry or not current_dir then
            return
          end

          -- Get relative path to current_dir from cwd
          local path = vim.fn.fnamemodify(current_dir, ':.')
          vim.fn.setreg("+", path .. entry.name)
        end,
        ["<leader>?"] = "actions.show_help",
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
    })

    require("which-key").add({ "<leader>d", "<CMD>Oil<CR>", desc = "Directory", noremap = true })
  end
}
