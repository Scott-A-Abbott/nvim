require "wolfe.remap"

local set = vim.opt
local gset = vim.g
local wset = vim.wo

-- Enable line numbers
wset.number = true

-- ## Netrw has some builtin functionality for buffers, too
-- ## Leave it in until it is a problem
-- Disable default file explorer
-- gset.loaded_netrw = 1
-- gset.gloaded_netrwPlugin = 1

-- For Which-Key timeout
set.timeoutlen = 250

-- Default tab sizing
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

-- Enable mouse functionality
set.mouse = "a"
