return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    local snacks = require("snacks")

    snacks.setup({
      picker = {
        enabled = true,
        ui_select = true,
        sources = {
          explorer = {
            focus = "input",
            actions = {
              -- Expand only (unlike confirm, which toggles and opens files).
              explorer_expand = function(picker, item)
                if not item or not item.dir or item.open then return end
                require("snacks.explorer.tree"):open(item.file)
                require("snacks.explorer.actions").update(picker, { refresh = true })
              end,
              -- Files: close the picker and open in the last used window.
              -- Directories: keep the default behavior (toggle open).
              explorer_confirm_close = function(picker, item)
                if not item then return end
                if item.dir then
                  picker:action("confirm")
                  return
                end
                local win = picker.main
                local path = snacks.picker.util.path(item)
                picker:close()
                if win and vim.api.nvim_win_is_valid(win) then
                  vim.api.nvim_set_current_win(win)
                end
                vim.cmd.edit(vim.fn.fnameescape(path))
              end,
            },
            win = {
              input = {
                keys = {
                  ["<CR>"] = { "explorer_confirm_close", mode = { "n", "i" } },
                  -- Insert mode only; in normal mode these fall through to the
                  -- global <C-h>/<C-l> window navigation.
                  ["<c-l>"] = { "explorer_expand", mode = "i" },
                  ["<c-h>"] = { "explorer_close", mode = "i" },
                  ["<c-z>"] = { "explorer_close_all", mode = { "n", "i" } },
                },
              },
            },
          },
        },
        win = {
          input = {
            keys = {
              -- Same as snacks' default <c-q> (swallowed by zellij): sends the
              -- selection to quickfix, or all results if nothing is selected.
              ["<a-a>"] = { "qflist", mode = { "n", "i" } }
            }
          }
        }
      }
    })

    local picker = snacks.picker

    require("which-key").add({
      { "<leader>f", group = "Fuzzy Find" },
      { "<leader>ff", function() picker.files() end, desc = "File" },
      { "<leader>fl", function() picker.grep() end, desc = "Live grep" },
      { "<leader>fr", function() picker.resume() end, desc = "Resume" },
      { "<leader>fb", function() picker.buffers() end, desc = "Buffers" },
      { "<leader>fg", function() picker.git_log() end, desc = "Git Log" },
      { "<leader>fG", function() picker.git_log_file() end, desc = "Git Log (current file)" },
      { "<leader>fe", function() picker.explorer() end, desc = "File explorer" },
      noremap = true
    })
  end
}
