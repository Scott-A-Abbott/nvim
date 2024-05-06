-- Visual Multi mappings
local keymap_options = { noremap = true }
vim.api.nvim_set_keymap("n", "<C-d>", "<Plug>(VM-Add-Cursor-Down)", keymap_options)
vim.api.nvim_set_keymap("n", "<C-u>", "<Plug>(VM-Add-Cursor-Up)", keymap_options)
vim.api.nvim_set_keymap("n", "<C-f>", "<Plug>(VM-Add-Cursor-At-Word)", keymap_options)
vim.api.nvim_set_keymap("v", "<C-f>", "<Plug>(VM-Find-Subword-Under)", keymap_options)

-- Whichkey mappings
local wk = require("which-key")
local wkn = {}
local wkv = {}

-- Whichkey help
local help = { "<CMD>WhichKey<CR>", "Keys" }
wkn["?"] = help
wkv["?"] = help

-- Line navigation
local next_empty = { "10j", "10 lines down" }
wkn["<S-j>"] = next_empty
wkv["<S-j>"] = next_empty

local prev_empty = { "10k", "10 lines up" }
wkn["<S-k>"] = prev_empty
wkv["<S-k>"] = prev_empty

local end_of_line = { "$", "End of line" }
wkn["<S-l>"] = end_of_line
wkv["<S-l>"] = end_of_line


local start_of_line = { "^", "Start of line" }
wkn["<S-h>"] = start_of_line
wkv["<S-h>"] = start_of_line

-- Yank override
wkn["y"] = {}

local yank_end_of_line = { "y$", "End of line" }
wkn["y"]["<S-l>"] = yank_end_of_line

local yank_start_of_line = { "y^", "Start of line" }
wkn["y"]["<S-h>"] = yank_start_of_line

-- Window navigation
wkn["<C-h>"] = { "<C-w>h", "Move to left window" }
wkn["<C-j>"] = { "<C-w>j", "Move to down window" }
wkn["<C-k>"] = { "<C-w>k", "Move to up window" }
wkn["<C-l>"] = { "<C-w>l", "Move to right window" }
wkn["<C-o>"] = { "<C-w>o", "Close all other windows" }

-- Leader convenience
wkn["<leader>"] = { name = "Space" }
wkv["<leader>"] = { name = "Space" }
wkn["<leader>"]["q"] = { "<CMD>q<CR>", "Quit" }
wkn["<leader>"]["Q"] = { "<CMD>qall<CR>", "Quit all" }
wkn["<leader>"]["!"] = { "<CMD>q!<CR>", "Force quit" }
wkn["<leader>"]["w"] = { "<CMD>w<CR>", "Write buffer" }
wkn["<leader>"]["d"] = { "<CMD>Oil<CR>", "Directory" }

local paste = { "\"+p", "Paste from system clipboard" }
wkn["<leader>"]["v"] = paste
wkv["<leader>"]["v"] = paste

local copy = { "\"+y", "Copy to system clipboard" }
wkn["<leader>"]["c"] = copy
wkv["<leader>"]["c"] = copy

-- Harpoon
local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

wkn["<leader>"]["h"] = { harpoon_ui.toggle_quick_menu, "Harpoon toggle" }
wkn["<leader>"]["m"] = { harpoon_mark.add_file, "Harpoon mark" }
-- ## Verify what these mappings are on windows/linux
wkn["<leader>"][">"] = { harpoon_ui.nav_next, "Harpoon next" }
wkn["<leader>"]["<"] = { harpoon_ui.nav_prev, "Harpoon prev" }

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

-- Flash
local flash = require("flash")

local flash_line_jump = {
  function()
    flash.jump({
      search = { mode = "search", max_length = 0 },
      label = { after = { 0, 0 } },
      pattern = "^"
    })
  end,
  "Flash line"
}

local flash_forwards = {
  function()
    flash.jump({
      search = { forward = true, wrap = false, multi_window = false },
    })
  end,
  "Flash forwards"
}

local flash_backwards = {
  function()
    flash.jump({
      search = { forward = false, wrap = false, multi_window = false },
    })
  end,
  "Flash backwards"
}

wkn["<leader>"]["l"] = flash_line_jump
wkn["<leader>"]["/"] = flash_forwards
wkn["<leader>"]["?"] = flash_backwards

wkv["<leader>"]["l"] = flash_line_jump
wkv["<leader>"]["/"] = flash_forwards
wkv["<leader>"]["?"] = flash_backwards

-- Split Window
wkn["<leader>"]["p"] = { name = "Pane" }
wkn["<leader>"]["p"]["d"] = { "<CMD>split<CR>", "Down" }
wkn["<leader>"]["p"]["r"] = { "<CMD>vsplit<CR>", "Right"}

-- Buffer
wkn["<leader>"]["b"] = { name = "Buffer" }
wkn["<leader>"]["b"]["d"] = { "<CMD>bd<CR>", "Delete" }
wkn["<leader>"]["b"]["s"] = { "<CMD>enew<CR>", "Scratch" }

-- Replace
local spectre = require('spectre')

wkn["<leader>"]["r"] = { name = "Replace" }
wkn["<leader>"]["r"]["o"] = { function() spectre.open() end, "Open" }
wkn["<leader>"]["r"]["r"] = { function()
  spectre.open()
  spectre.resume_last_search()
end, "Resume" }

-- Tab
wkn["<leader>"]["t"] = { name = "Tab" }
wkn["<leader>"]["t"]["n"] = { "<CMD>tabnew<CR>", "New" }
wkn["<leader>"]["t"]["q"] = { "<CMD>tabclose<CR>", "Close current" }
wkn["<leader>"]["t"][">"] = { "<CMD>tabnext<CR>", "Next" }
wkn["<leader>"]["t"]["<"] = { "<CMD>tabprevious<CR>", "Previous" }

-- LSP
wkn[';'] = { name = "LSP" }
wkn[';']['a'] = { vim.lsp.buf.code_action, "Code action" }
wkn[';']['d'] = { vim.lsp.buf.definition, "Go to definition" }
wkn[';']['D'] = { vim.lsp.buf.declaration, "Go to declaration" }
wkn[';']['i'] = { vim.lsp.buf.implementation, "List implementations" }
wkn[';']['h'] = { vim.lsp.buf.hover, "Code hover" }
wkn[';']['n'] = { vim.lsp.buf.rename, "Rename" }
wkn[';']['r'] = { vim.lsp.buf.references, "List references" }
wkn[';']['t'] = { vim.lsp.buf.type_definition, "Type definition" }
wkn[';']['f'] = { vim.lsp.buf.formatting, "Formatting" }
wkn[';']['e'] = { vim.diagnostic.open_float, "Open float" }
wkn[';']['['] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" }
wkn[';'][']'] = { vim.diagnostic.goto_next, "Go to next diagnostic" }

-- Casing
local textcase = require("textcase")

wkn["C"] = { name = "Casing" }
wkv["C"] = { name = "Casing" }

wkn["C"]['_'] = { function() textcase.current_word("to_snake_case") end, "snake_case" }
wkv["C"]['_'] = { function() textcase.operator("to_snake_case") end, "snake_case" }

wkn["C"]['-'] = { function() textcase.current_word("to_dash_case") end, "dash-case" }
wkv["C"]['-'] = { function() textcase.operator("to_dash_case") end, "dash-case" }

wkn["C"]['c'] = { function() textcase.current_word("to_camel_case") end, "camelCase" }
wkv["C"]['c'] = { function() textcase.operator("to_camel_case") end, "camelCase" }

wkn["C"]['C'] = { function() textcase.current_word("to_constant_case") end, "CONSTANT_CASE" }
wkv["C"]['C'] = { function() textcase.operator("to_constant_case") end, "CONSTANT_CASE" }

wkn["C"]['l'] = { function() textcase.current_word("to_lower_case") end, "lower case" }
wkv["C"]['l'] = { function() textcase.operator("to_lower_case") end, "lower case" }

wkn["C"]['p'] = { function() textcase.current_word("to_pascal_case") end, "PascalCase" }
wkv["C"]['p'] = { function() textcase.operator("to_pascal_case") end, "PascalCase" }

wkn["C"]['s'] = { function() textcase.current_word("to_phrase_case") end, "Sentence case" }
wkv["C"]['s'] = { function() textcase.operator("to_phrase_case") end, "Sentence case" }

wkn["C"]['t'] = { function() textcase.current_word("to_title_case") end, "Title Case" }
wkv["C"]['t'] = { function() textcase.operator("to_title_case") end, "Title Case" }

wkn["C"]['u'] = { function() textcase.current_word("to_upper_case") end, "UPPER CASE" }
wkv["C"]['u'] = { function() textcase.operator("to_upper_case") end, "UPPER CASE" }

-- Treesitter context
wkn["<leader>"]["T"] = { name = "Treesitter" }
wkn["<leader>"]["T"]["c"] = { "<CMD>TSContextToggle<CR>", "Context" }

-- Register mappings
wk.register(wkn, { mode = "n", noremap = true })
wk.register(wkv, { mode = "v", noremap = true })
