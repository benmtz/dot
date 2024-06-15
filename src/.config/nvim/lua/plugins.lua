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
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme('gruvbox-material')
    end
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
  { "lukas-reineke/indent-blankline.nvim" },
  { "folke/trouble.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
  { 'ckipp01/nvim-jenkinsfile-linter', dependencies = { "nvim-lua/plenary.nvim" } },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' } },
  {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }
})

