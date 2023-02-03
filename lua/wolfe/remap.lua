vim.g.mapleader = " "

-- Telescope
local builtin = require "telescope.builtin"
-- vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
-- vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
-- vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    name = "Space",

    f = {
      name = "Fuzzy find",
      f = { "<CMD>Telescope find_files<CR>", "File" },
      g = { "<CMD>Telescope git_files<CR>", "Git recognized file" },
      s = { "<CMD>Telescope live_grep<CR>", "String grep" },
      b = { "<CMD>Telescope buffers<CR>", "Buffers" },
      c = { "<CMD>Telescope current_buffer_fuzzy_find<CR>", "In current buffer" },
    },

    w = {
      name = "[W]indow",
      v = { "<CMD>vsplit<CR>", "[V]ertical Split"},
      h = { "<CMD>split<CR>", "[H]orizontal Split" },
    },

    b = {
      name = "[B]uffer"
    },

    d = {
      name = "[D]irectory Explorer (Drex)",
      o = {
        function ()
          local drex = require('drex')
          local elements = require('drex.elements')
          local path = vim.fn.expand("%:p")

          drex.open_directory_buffer() -- open at cwd

          if not (path == "") then
            elements.focus_element(0, path)
          end
        end,
        "[O]pen"
      },
    }
  }
})

local elements = require("drex.elements")
local drex_utils = require("drex.utils")

require("drex.config").configure {
  keybindings = {
    ["n"] = {
      ["<CR>"] = function()
        local line = vim.api.nvim_get_current_line()

        if drex_utils.is_open_directory(line) then
          elements.collapse_directory()
        else
          elements.expand_element()
        end
      end,

      ["]"] = function()
        local line = vim.api.nvim_get_current_line()

        local path
        if drex_utils.is_directory(line) then
          path = drex_utils.get_element(line) .. drex_utils.path_separator
        else
          path = drex_utils.get_path(line)
        end

        elements.open_directory(path)
        vim.api.nvim_set_current_dir(path)
      end,

      ["["] = function()
        elements.open_parent_directory()
        -- This could be wrong. Is there a chance it sets a different directory than intended?
        vim.api.nvim_set_current_dir("..")
      end
    }
  }
}
