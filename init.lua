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
  local popup ---@type table? the open popup, so we never stack two
  local last_key = vim.uv.now() -- last keypress in this instance

  local function notify()
    if not pending then return end
    pending = false
    if popup and popup.win and vim.api.nvim_win_is_valid(popup.win) then return end
    local ok = pcall(function()
      popup = Snacks.win({
        text = {
          "",
          "  Neovim config/plugins changed on disk.",
          "  Restart Neovim to apply.",
          "",
          "  Press <Enter> to dismiss",
        },
        position = "float",
        width = 50,
        height = 5,
        border = "rounded",
        title = " Config changed ",
        title_pos = "center",
        enter = true,
        backdrop = 60,
        bo = { modifiable = false, filetype = "config_changed" },
        keys = {
          ["<CR>"] = "close",
          ["<Esc>"] = "close",
          q = "close",
        },
      })
    end)
    if not ok then
      vim.notify("Neovim config/plugins changed on disk. Restart to apply.", vim.log.levels.WARN)
    end
  end

  -- Focus events aren't always delivered (terminal/multiplexer dependent), so
  -- "was I just using this instance?" is judged by recent keypresses too.
  vim.on_key(function() last_key = vim.uv.now() end)

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
      -- A change that lands while I'm actively using this instance (a save, a
      -- neogit revert, ...) was made from here, so don't report it.
      if focused and vim.uv.now() - last_key < 10000 then return end
      pending = true
      -- Idle but (as far as we know) focused: nothing else will trigger it.
      if focused then vim.schedule(notify) end
    end,
  })
end
require("wolfe")
