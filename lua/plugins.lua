function relative_path()
  return vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.')
end

function current_directory()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end
 
return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.x",
    requires = { {"nvim-lua/plenary.nvim"} },
    config = function()
      require "telescope".setup {}
    end,
  }

  use {
    "Shatur/neovim-ayu",
    config = function()
      vim.opt.termguicolors = true
      vim.wo.cursorline = true

      require("ayu").setup({
        mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
        overrides = {
          LineNr = { fg = "#8691A3" },
          -- Cursor = { fg = "#000000", bg = "#FFFFFF" },
          CursorLine = { bg = "#0A0E14" },
          CursorLineNr = { fg = "#FFCC66" },
          WhichKeyFloat = { bg = "#333C52" },
          Comment = { fg = "#8691A3" },
        }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
      })

      local set_colorscheme = "silent! colorscheme ayu"
      vim.cmd(set_colorscheme)
    end
  }

  use { 
    "TimUntersberger/neogit",
    requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
    config = function()
      require "neogit".setup {
        integrations = { diffview = true },
      }
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    "theblob42/drex.nvim",
    requires = "kyazdani42/nvim-web-devicons", -- optional
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "nvim-treesitter.configs".setup {
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
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", "f-person/git-blame.nvim"},
    config = function()
      vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
      vim.g.gitblame_message_template = '<author> • <date>'
      local git_blame = require('gitblame')

      require "lualine".setup({
        extensions = { "nvim-tree", "drex" },
        options = { theme = "ayu" },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { current_directory },
          lualine_c = { relative_path },
          lualine_x = {
            { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
          },
          lualine_y = {'branch'},
          lualine_z = {'location'}
        },
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

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      -- {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      -- {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    },
    config = function()
      -- Learn the keybindings, see :help lsp-zero-keybindings
      -- Learn to configure LSP servers, see :help lsp-zero-api-showcase
      local lsp = require('lsp-zero')
      lsp.preset('recommended')

      -- (Optional) Configure lua language server for neovim
      -- lsp.nvim_workspace()

      lsp.setup()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

end)
