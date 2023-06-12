-- Visual Multi remap
local keymap_options = { noremap = true }
vim.api.nvim_set_keymap("n", "<C-d>", "<Plug>(VM-Add-Cursor-Down)", keymap_options)
vim.api.nvim_set_keymap("n", "<C-u>", "<Plug>(VM-Add-Cursor-Up)", keymap_options)

local wk = require("which-key")
wk.register({
  ["?"] = { "<CMD>WhichKey<CR>", "Keys" },
  ["<leader>"] = {
    name = "Space",

    q = { "<CMD>q<CR>", "Quit" },
    Q = { "<CMD>q!<CR>", "Force quit" },
    w = { "<CMD>w<CR>", "Write buffer" },

    f = {
      name = "Fuzzy find",
      f = { "<CMD>FzfLua files<CR>", "File" },
      l = { "<CMD>FzfLua live_grep<CR>", "Live grep" },
      r = { "<CMD>FzfLua resume<CR>", "Resume grep" },
      b = { "<CMD>FzfLua buffers<CR>", "Buffers" },
    },

    g = {
      name = "Git",
      o = { "<CMD>Neogit<CR>", "Open" },
      c = { "<CMD>Neogit commit<CR>", "Commit" },
      p = { "<CMD>Neogit pull<CR>", "Pull" },
      l = { "<CMD>Neogit log<CR>", "Log" },
      ["P"] = { "<CMD>Neogit push<CR>", "Push" },
    },

    W = {
      name = "Window",
      v = { "<CMD>vsplit<CR>", "Vertical split"},
      h = { "<CMD>split<CR>", "Horizontal split" },
    },

    b = {
      name = "Buffer",
      d = { "<CMD>bd<CR>", "Delete" },
      s = { "<CMD>enew<CR>", "Scratch" },
    },

    d = {
      function()
        local drex = require('drex')
        local elements = require('drex.elements')
        local path = vim.fn.expand("%:p")

        drex.open_directory_buffer() -- open at cwd

        if not (path == "") then
          pcall(elements.focus_element, 0, path)
        end
      end,
      "Drex"
    },

    r = {
      name = "Replace",
      p = { "<CMD>MurenToggle<CR>", "Resume previous" },
      r = { "<CMD>MurenFresh<CR>", "New" },
    },

    t = {
      name = "Tab",
      n = { "<CMD>tabnew<CR>", "New" },
      q = { "<CMD>tabclose<CR>", "Close current" },
      [">"] = { "<CMD>tabnext<CR>", "Next" },
      ["<"] = { "<CMD>tabprevious<CR>", "Previous" },
    }
  },
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

      ["J"] = function()
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

      ["K"] = function()
        elements.open_parent_directory()
        -- This could be wrong. Is there a chance it sets a different directory than intended?
        vim.api.nvim_set_current_dir("..")
      end,

      ["q"] = function()
        local handle = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_delete(handle, { force = true })
      end
    }
  }
}
