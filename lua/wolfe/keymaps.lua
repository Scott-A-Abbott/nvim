local nv = { "n", "v" }

local line_navigation = {
  { "<S-j>", "10j", desc = "10 lines down", mode = nv },
  { "<S-k>", "10k", desc = "10 lines up", mode = nv },
  { "<S-l>", "$", desc = "End of line", mode = nv },
  { "<S-h>", "^", desc = "Start of line", mode = nv },
}

local yank_override = {
  { "yL", "y$", desc = "Yank to end of line" },
  { "yH", "y^", desc = "Yand to start of line" }
}

local window_navigation = {
  { "<C-h>", "<C-w>h", desc = "Move to left window" },
  { "<C-j>", "<C-w>j", desc = "Move to down window" },
  { "<C-k>", "<C-w>k", desc = "Move to up window" },
  { "<C-l>", "<C-w>l", desc = "Move to right window" },
  { "<C-o>", "<C-w>o", desc = "Close all other windows" }
}

local leader = {
  { "<leader>", group = "Leader" },
  -- Quit
  { "<leader>q", "<CMD>q<CR>", desc = "Quit" },
  { "<leader>Q", "<CMD>qall<CR>", desc = "Quit all" },
  { "<leader>!", "<CMD>q!<CR>", desc = "Force quit" },
  { "<leader>w", "<CMD>w<CR>", desc = "Write buffer" },
  -- Clipboard
  { "<leader>v", "\"+p", desc = "Paste from system clipboard", mode = nv },
  { "<leader>v", "\"+y", desc = "Copy to system clipboard", mode = nv },
  -- Split Window
  { "<leader>p", group = "Pane" },
  { "<leader>pd", "<CMD>split<CR>", desc = "Down" },
  { "<leader>pr", "<CMD>vsplit<CR>", desc = "Right" },
  { "<leader>pf", "<CMD>tab split<CR>", desc = "Fullscreen" },
  -- Buffer
  { "<leader>b", group = "Buffer" },
  { "<leader>bd", "<CMD>bd<CR>", desc = "Delete" },
  { "<leader>bs", "<CMD>enew<CR>", desc = "Scratch" },
  -- Tab
  { "<leader>t", group = "Tab" },
  { "<leader>tn", "<CMD>tabnew<CR>", desc = "New" },
  { "<leader>t>", "<CMD>tabnext<CR>", desc = "Next" },
  { "<leader>t<", "<CMD>tabprevious<CR>", desc = "Previous" },
}

local lsp = {
  { ";", group = "LSP" },
  { ";a", vim.lsp.buf.code_action, desc = "Code action" },
  { ";d", vim.lsp.buf.definition, desc = "Go to definition" },
  { ";D", vim.lsp.buf.declaration, desc = "Go to declaration" },
  { ";i", vim.lsp.buf.implementation, desc = "List implementations" },
  { ";h", vim.lsp.buf.hover, desc = "Code hover" },
  { ";n", vim.lsp.buf.rename, desc = "Rename" },
  { ";r", vim.lsp.buf.references, desc = "List references" },
  { ";t", vim.lsp.buf.type_definition, desc = "Type definition" },
  { ";f", vim.lsp.buf.formatting, desc = "Formatting" },
  { ";e", vim.lsp.buf.open_float, desc = "Open float" },
  { ";[", vim.lsp.buf.goto_prev, desc = "Go to previous diagnostic" },
  { ";]", vim.lsp.buf.goto_next, desc = "Go to next diagnostic" },
}

require("which-key").add({
  leader,
  line_navigation,
  window_navigation,
  yank_override,
  lsp,
  noremap = true
})
