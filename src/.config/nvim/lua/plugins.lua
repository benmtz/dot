local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
require("lazy").setup({
  --  INIT plugins --
	{ 'nvim-treesitter/nvim-treesitter', lazy = false, priority = 1000 },
  { 'folke/tokyonight.nvim', lazy = false, priority = 1000,
      config = function()
        require("tokyonight").setup({
          style = "night",
          transparent = true,
          floats = "dark",
          on_colors = function(colors)
            -- colors.fg_gutter = "#5081c0"
            colors.comment = "#709db2"
            colors.dark5 = "#709db2"
            colors.border = "#fefefe"
            colors.bg_float = colors.none
          end,
          on_highlights = function(hl, colors)
            hl.LineNr = {
              fg = "#ffba00"
              -- fg = "#5081c0"
            }
            hl.qfLineNr = {
              -- fg = "#737aa2"
              fg = "#ffba00"
            }
            hl.CursorLineNr = {
              fg = "#ffba00"
            }
          end
        })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
	{ 'norcalli/nvim-colorizer.lua' },
	{ 'folke/which-key.nvim', lazy = true },
  { 'sheerun/vim-polyglot' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'voldikss/vim-floaterm' },
  { 'nvim-telescope/telescope.nvim',
    dependencies = {
 		  {'nvim-lua/plenary.nvim'},
 			{'nvim-telescope/telescope-file-browser.nvim'},
 			{ 'benmtz/telescope-go-task.nvim' }
    }
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { 'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'dcampos/cmp-snippy',
      'dcampos/nvim-snippy',
    }
  },
  { 'rmagatti/auto-session',
     lazy = false,
     priority = 1000,
     config = function()
       require("auto-session").setup {
         log_level = "error",
         auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
       }
     end
  },
	{ 'terrortylor/nvim-comment' },
  { "lukas-reineke/indent-blankline.nvim" },
  { "folke/trouble.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
  { 'ckipp01/nvim-jenkinsfile-linter', dependencies = { "nvim-lua/plenary.nvim" } },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' } }
})

