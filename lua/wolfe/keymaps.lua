-- Visual Multi mappings
local keymap_options = { noremap = true }
vim.api.nvim_set_keymap("n", "<C-d>", "<Plug>(VM-Add-Cursor-Down)", keymap_options)
vim.api.nvim_set_keymap("n", "<C-u>", "<Plug>(VM-Add-Cursor-Up)", keymap_options)

-- Whichkey mappings
local wk = require("which-key")
local wkmap = {}
wkmap["n"] = {}
wkmap["v"] = {}

-- Whichkey help
wkmap["n"]["?"] = { "<CMD>WhichKey<CR>", "Keys" }
wkmap["v"]["?"] = { "<CMD>WhichKey<CR>", "Keys" }

wkmap["n"]["<leader>"] = { name = "Space" }
wkmap["n"]["<leader>"]["q"] = { "<CMD>q<CR>", "Quit" }
wkmap["n"]["<leader>"]["Q"] = { "<CMD>q!<CR>", "Force quit" }
wkmap["n"]["<leader>"]["w"] = { "<CMD>w<CR>", "Write buffer" }
wkmap["n"]["<leader>"]["d"] = {
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
wkmap["n"]["<leader>"]["f"] = { name = "Fuzzy Find" }
wkmap["n"]["<leader>"]["f"]["f"] = { "<CMD>FzfLua files<CR>", "File" }
wkmap["n"]["<leader>"]["f"]["l"] = { "<CMD>FzfLua live_grep<CR>", "Live grep" }
wkmap["n"]["<leader>"]["f"]["r"] = { "<CMD>FzfLua resume<CR>", "Resume grep" }
wkmap["n"]["<leader>"]["f"]["b"] = { "<CMD>FzfLua buffers<CR>", "Buffers" }

-- Git
wkmap["n"]["<leader>"]["g"] = { name = "Git" }
wkmap["n"]["<leader>"]["g"]["o"] = { "<CMD>Neogit<CR>", "Open" }
wkmap["n"]["<leader>"]["g"]["c"] = { "<CMD>Neogit commit<CR>", "Commit" }
wkmap["n"]["<leader>"]["g"]["p"] = { "<CMD>Neogit pull<CR>", "Pull" }
wkmap["n"]["<leader>"]["g"]["l"] = { "<CMD>Neogit log<CR>", "Log" }

-- Split Window
wkmap["n"]["<leader>"]["s"] = { name = "Split" }
wkmap["n"]["<leader>"]["s"]["h"] = { "<CMD>split<CR>", "Horizontal" }
wkmap["n"]["<leader>"]["s"]["v"] = { "<CMD>vsplit<CR>", "Vertical"}

-- Buffer
wkmap["n"]["<leader>"]["b"] = { name = "Buffer" }
wkmap["n"]["<leader>"]["b"]["d"] = { "<CMD>bd<CR>", "Delete" }
wkmap["n"]["<leader>"]["b"]["s"] = { "<CMD>enew<CR>", "Scratch" }

-- Replace
wkmap["n"]["<leader>"]["r"] = { name = "Replace" }
wkmap["n"]["<leader>"]["r"]["r"] = { "<CMD>MurenToggle<CR>", "Resume previous" }
wkmap["n"]["<leader>"]["r"]["n"] = { "<CMD>MurenFresh<CR>", "New" }

-- Tab
wkmap["n"]["<leader>"]["t"] = { name = "Tab" }
wkmap["n"]["<leader>"]["t"]["n"] = { "<CMD>tabnew<CR>", "New" }
wkmap["n"]["<leader>"]["t"]["q"] = { "<CMD>tabclose<CR>", "Close current" }
wkmap["n"]["<leader>"]["t"][">"] = { "<CMD>tabnext<CR>", "Next" }
wkmap["n"]["<leader>"]["t"]["<"] = { "<CMD>tabprevious<CR>", "Previous" }

wk.register(wkmap["n"], { mode = "n" })
wk.register(wkmap["v"], { mode = "v" })

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
