return require("packer").startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require "telescope".setup {}
    end,
  }

  -- use {
  --   "ayu-theme/ayu-vim",
  --   config = function()
  --     vim.opt.termguicolors = true
  --     vim.g.ayucolor = "mirage"

  --     local set_colorscheme = "silent! colorscheme ayu"
  --     vim.cmd(set_colorscheme)
  --   end,
  -- }

  use {
    "Shatur/neovim-ayu",
    config = function()
      vim.opt.termguicolors = true
      vim.wo.cursorline = true

      require('ayu').setup({
        mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
        overrides = {
          LineNr = { fg = "#8691A3" },
          -- Cursor = { fg = "#000000", bg = "#FFFFFF" },
          CursorLine = { bg = "#0A0E14" },
          CursorLineNr = { fg = "#FFCC66" },
          WhichKeyFloat = { bg = "#333C52" },
        }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
      })

      local set_colorscheme = "silent! colorscheme ayu"
      vim.cmd(set_colorscheme)
    end
  }

  use { 
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require "neogit".setup {}
    end,
  }

  use {
    'theblob42/drex.nvim',
    requires = 'kyazdani42/nvim-web-devicons', -- optional
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "bash", "css", "dockerfile", "html", "help", "javascript", "typescript", "tsx", "json", "markdown", "scss", "sql", "lua", "ruby", "rust", "toml", "yaml", },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        }
      }
    end
  }

  use { 
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }

  use {
    "karb94/neoscroll.nvim",
    config = function() require("neoscroll").setup() end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require "lualine".setup({
        extensions = { "nvim-tree", "drex" },
        options = { theme = "ayu" },
      })
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        window = {
          border = "shadow", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0
        },
        hidden = { "<silent>", "<CR>", "call", "lua", "^:", "^ "},
      }
    end
  }

  use "mg979/vim-visual-multi"
end)
