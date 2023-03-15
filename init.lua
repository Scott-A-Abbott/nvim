require "plugins"
require "wolfe"

local drex = require("drex")

local path = vim.fn.expand("%:p")
local is_dir = vim.fn.isdirectory(path)

if is_dir == 1 then
  vim.api.nvim_set_current_dir(path)
  drex.open_directory_buffer()
end

vim.opt.spell = true
vim.g.spelllang = "en_us"

-- Set yank to use clipboard by default
vim.cmd [[set clipboard+=unnamedplus]]
