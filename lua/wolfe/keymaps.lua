-- Visual Multi mappings
local keymap_options = { noremap = true }
vim.api.nvim_set_keymap("n", "<C-d>", "<Plug>(VM-Add-Cursor-Down)", keymap_options)
vim.api.nvim_set_keymap("n", "<C-u>", "<Plug>(VM-Add-Cursor-Up)", keymap_options)

-- Whichkey mappings
local wk = require("which-key")
local wkn = {}
local wkv = {}

-- Whichkey help
local help = { "<CMD>WhichKey<CR>", "Keys" }
wkn["?"] = help
wkv["?"] = help

-- Line navigation
local next_empty = { "}", "Next empty line" }
wkn["<S-j>"] = next_empty
wkv["<S-j>"] = next_empty

local prev_empty = { "{", "Previous empty line" }
wkn["<S-k>"] = prev_empty
wkv["<S-k>"] = prev_empty

-- Window navigation
wkn["<C-h>"] = { "<C-w>h", "Move to left window" }
wkn["<C-j>"] = { "<C-w>j", "Move to down window" }
wkn["<C-k>"] = { "<C-w>k", "Move to up window" }
wkn["<C-l>"] = { "<C-w>l", "Move to right window" }
wkn["<C-o>"] = { "<C-w>o", "Close all other windows" }

wkn["<leader>"] = { name = "Space" }
wkn["<leader>"]["q"] = { "<CMD>q<CR>", "Quit" }
wkn["<leader>"]["Q"] = { "<CMD>q!<CR>", "Force quit" }
wkn["<leader>"]["w"] = { "<CMD>w<CR>", "Write buffer" }
wkn["<leader>"]["d"] = {
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
}

-- Fuzzy Find
wkn["<leader>"]["f"] = { name = "Fuzzy Find" }
wkn["<leader>"]["f"]["f"] = { "<CMD>FzfLua files<CR>", "File" }
wkn["<leader>"]["f"]["l"] = { "<CMD>FzfLua live_grep<CR>", "Live grep" }
wkn["<leader>"]["f"]["r"] = { "<CMD>FzfLua resume<CR>", "Resume grep" }
wkn["<leader>"]["f"]["b"] = { "<CMD>FzfLua buffers<CR>", "Buffers" }

-- Git
wkn["<leader>"]["g"] = { name = "Git" }
wkn["<leader>"]["g"]["o"] = { "<CMD>Neogit<CR>", "Open" }
wkn["<leader>"]["g"]["c"] = { "<CMD>Neogit commit<CR>", "Commit" }
wkn["<leader>"]["g"]["p"] = { "<CMD>Neogit pull<CR>", "Pull" }
wkn["<leader>"]["g"]["l"] = { "<CMD>Neogit log<CR>", "Log" }

-- Split Window
wkn["<leader>"]["s"] = { name = "Split" }
wkn["<leader>"]["s"]["h"] = { "<CMD>split<CR>", "Horizontal" }
wkn["<leader>"]["s"]["v"] = { "<CMD>vsplit<CR>", "Vertical"}

-- Buffer
wkn["<leader>"]["b"] = { name = "Buffer" }
wkn["<leader>"]["b"]["d"] = { "<CMD>bd<CR>", "Delete" }
wkn["<leader>"]["b"]["s"] = { "<CMD>enew<CR>", "Scratch" }

-- Replace
wkn["<leader>"]["r"] = { name = "Replace" }
wkn["<leader>"]["r"]["r"] = { "<CMD>MurenToggle<CR>", "Resume previous" }
wkn["<leader>"]["r"]["n"] = { "<CMD>MurenFresh<CR>", "New" }

-- Tab
wkn["<leader>"]["t"] = { name = "Tab" }
wkn["<leader>"]["t"]["n"] = { "<CMD>tabnew<CR>", "New" }
wkn["<leader>"]["t"]["q"] = { "<CMD>tabclose<CR>", "Close current" }
wkn["<leader>"]["t"][">"] = { "<CMD>tabnext<CR>", "Next" }
wkn["<leader>"]["t"]["<"] = { "<CMD>tabprevious<CR>", "Previous" }

wk.register(wkn, { mode = "n", noremap = true })
wk.register(wkv, { mode = "v", noremap = true })

-- Drex
local elements = require("drex.elements")
local drex_utils = require("drex.utils")
local drex_config = require("drex.config")
local dmap = {}
dmap["n"] = {}

-- Select or expand
dmap["n"]["<CR>"] = function()
  local line = vim.api.nvim_get_current_line()

  if drex_utils.is_open_directory(line) then
    elements.collapse_directory()
  else
    elements.expand_element()
  end
end

-- CD down
dmap["n"]["J"] = function()
  local line = vim.api.nvim_get_current_line()

  local path
  if drex_utils.is_directory(line) then
    path = drex_utils.get_element(line) .. drex_utils.path_separator
  else
    path = drex_utils.get_path(line)
  end

  elements.open_directory(path)
  vim.api.nvim_set_current_dir(path)
end

-- CD up
dmap["n"]["K"] = function()
  elements.open_parent_directory()
  -- This could be wrong. Is there a chance it sets a different directory than intended?
  vim.api.nvim_set_current_dir("..")
end

-- Quit
dmap["n"]["q"] = function()
  local handle = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_delete(handle, { force = true })
end

drex_config.configure {
  keybindings = dmap
}
