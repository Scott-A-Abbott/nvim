local drex = require("drex")

local path = vim.fn.expand("%:p")
local is_dir = vim.fn.isdirectory(path)

if is_dir == 1 then
  vim.api.nvim_set_current_dir(path)
  drex.open_directory_buffer()
end

local api = vim.api
local set = vim.opt
local gset = vim.g
local wset = vim.wo

-- Enable line numbers
wset.number = true

-- Spellcheck
set.spell = true
gset.spelllang = "en_us"

-- For Which-Key timeout
set.timeoutlen = 250

-- Default tab sizing
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

-- Enable mouse functionality
set.mouse = "a"

-- Split behaviour
set.splitbelow = true
set.splitright = true

-- Dont show mode since we have a statusline
set.showmode = false

-- Set terminal title
set.title = true

local function current_directory()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

api.nvim_create_autocmd({ "BufEnter" }, {
  group = api.nvim_create_augroup("wolfe_title" , { clear = true }),
  callback = function()
    set.titlestring = current_directory()
  end
})

api.nvim_create_autocmd({ "BufEnter" }, {
  group = api.nvim_create_augroup("zellij_tab", { clear = true }),
  callback = function()
    vim.cmd(string.format("silent !zellij action rename-tab %s", current_directory()))
  end
})

-- Auto trim trailing white space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = false,
})

-- Display border to LSP floating panes
local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config{
  float={border=_border}
}
