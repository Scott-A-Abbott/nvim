vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim's own change notification fires on every save of a plugin spec,
-- which spams every open instance. Silence it and batch into one notice that
-- is shown when the instance is next focused.
require("lazy").setup("plugins", { change_detection = { notify = false } })

do
  local focused = true
  local pending = false
  local timer = assert(vim.uv.new_timer())

  local function notify()
    if not pending then return end
    pending = false
    vim.notify("Neovim config/plugins changed on disk. Restart to apply.", vim.log.levels.WARN)
  end

  vim.api.nvim_create_autocmd("FocusLost", { callback = function() focused = false end })
  vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
      focused = true
      -- Defer so it shows once focus has fully settled.
      vim.defer_fn(notify, 100)
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyReload",
    callback = function()
      pending = true
      if focused then
        -- Debounce rapid saves in the instance being edited.
        timer:stop()
        timer:start(3000, 0, vim.schedule_wrap(notify))
      end
    end,
  })
end
require("wolfe")
